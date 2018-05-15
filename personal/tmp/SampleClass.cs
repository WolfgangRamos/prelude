using System;
using System.Collections.Generic;
using System.Linq;
namespace ConsoleApp1
{
    public class ProBreak : BaseProcess
    {
        public int shift;
        public DateTime tourDate;
        public DateTime timeStamp;
        // ANF-04814-H6V6N2, ANF-05861-Q5K5F8: entspricht Abwesenheitstyp aus Tabelle VTSBREAKTYPES
        public int breakTypeNr;
        // ANF-09017-J5H8N0: entspricht Inventurnummer aus Tabelle VTSMTINVENTUR
        public int inventoryNr;
        public string pC;
        public string city;
        public string country;
        public string street;
        public string district;
        public int groupNr;
        public string groupRule;
        private DBList<DBBreak> _breaks;
        public List<int> workerNrs = new List<int>();
        private object workerNr;
        private const int MAX_BREAKS = 12;
        
        public static ProBreak Create(WebCommand wc)
        {
            ProBreak res;
            res = new ProBreak();
            res.SetWebService(wc);
            return res;
        }
        
        public void CreateGroup(bool _replan = true)
        {
            int count;
            IDateTimeIterator dtIterator;
            DateTime startDate, endDate;
            if (!CreateIterator(out dtIterator, out startDate, out endDate, out count))
            {
                return;
            }
            var breaks = CreateBreaks(dtIterator, startDate, endDate, count);
            SaveBreaks(_replan, breaks);
        }
        private DBList<DBBreak> CreateBreaks(IDateTimeIterator _dtIterator, DateTime _startDate, DateTime _endDate, int _count)
        {
            var breaks = new DBList<DBBreak>();
            _count = _count.Min(MAX_BREAKS);
            foreach (var dt in _dtIterator.GetIterator(_startDate, _endDate, 0, _count))
            {
                //Abwesenheit in MT Auftrag evtl. verboten
                //ANF-06805-F1G6Z2|Lifta|
                if (!Data.IsAbsenceAllowed(WorkerNr, dt + Begin.TimeOfDay, mandant.MTOhneAbwesenheiten))
                    continue;
                foreach (var workerNr in workerNrs)
                {
                    var b = MakeBreak();
                    b.WorkerNr = workerNr;
                    b.Nr = Data.GetBreakSequence();
                    if (groupNr == 0)
                    {
                        groupNr = b.Nr;
                    }
                    b.GroupNr = groupNr;
                    b.GroupRule = groupRule;
                    b.Begin = dt + Begin.TimeOfDay;
                    b.Date = dt;
                    breaks.Add(b);
                    EventHub.Handle(lang, EventType.WorkerBreak, DateTime.Now, this.GetType().Name,
                                    this.username, EventParams.Create("workernr", workerNr, "info",
                                                                      FLS.Texts.Text.Get(lang, FLS.Texts.Text.Pauseaenderung), "text",
                                                                      FLS.Texts.Text.Get(lang, FLS.Texts.Text.Pauseaenderung) + ":" + b.Begin, "shift", shift));
                }
            }
            return breaks;
        }
        private void SaveBreaks(bool _replan, DBList<DBBreak> _breaks)
        {
            foreach (var b in _breaks)
            {
                b.Save();
                if (_replan)
                {
                    Replan(b.Date);
                }
            }
        }
        public void Replan(DateTime _date)
        {
            ProOptimize pro = ProOptimize.Create(this.wc);
            pro.WorkerNr = workerNr;
            pro.DateFrom = _date;
            pro.DateTo = _date;
            pro.ForceSave = true;
            pro.OptimizeWorker(false, DayOptMode.Daywise, WorkerOptModus.Optimize, OAModus.None); //Mit nix, nur aktueller Mitarbeiter
        }
        
        public void SetState()
        {
            dbBreak = Data.LoadBreak(BreakNr, "");
            if (dbBreak == null)
            {
                SetError(Error.PauseNichtGefunden);
                return;
            }
            if (dbBreak.Status >= (int)AuftragStatus.Erledigt)
            {
                SetError(Error.PauseBereitsErledigt, string.Format("{0} -> {1}", dbBreak.Status, NewState));
                return;
            }
            if ((int)NewState <= dbBreak.Status)
            {
                SetError(Error.PauseStatusZuHoch, string.Format("{0} -> {1}", dbBreak.Status, NewState));
                return;
            }
            if ((int)NewState == dbBreak.Status)
            {
                SetError(Error.PauseStatusBereitsGemeldet, string.Format("{0} -> {1}", dbBreak.Status, NewState));
                return;
            }

            
            bool res = false;
            switch (NewState)
            {
                case AuftragStatus.Bestaetigt:
                    {
                        res = SetStateBestaetigt();
                        break;
                    }
                case AuftragStatus.Anfahrt:
                    {
                        res = SetStateAnfahrt();
                        break;
                    }
                case AuftragStatus.Ankunft:
                    {
                        res = SetStateAnkunft();
                        break;
                    }
                case AuftragStatus.Erledigt:
                    {
                        res = SetStateErledigt();
                        break;
                    }
                case AuftragStatus.TeilErledigt:
                    {
                        res = SetStateTeilErledigt();
                        break;
                    }
                case AuftragStatus.Abgelehnt:
                    {
                        res = SetStateAbgelehnt();
                        break;
                    }
                case AuftragStatus.Abgebrochen:
                    {
                        res = SetStateAbgebrochen();
                        break;
                    }
                case AuftragStatus.NichtAngetroffen:
                    {
                        res = SetStateNichtAngetroffen();
                        break;
                    }
                case AuftragStatus.Abgeschlossen:
                    {
                        res = SetStateAbgeschlossen();
                        break;
                    }
            }
            if (res)
            {
                Replan(Begin.Date);
            }
            dbBreak = null;
        }
    }
}
