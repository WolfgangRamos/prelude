using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmacsFindReferencesTest
{
    class Folder
    {
        public string Name { get; set;}
        public DateTime timestamp;

        public Folder(string name)
        {
            this.Name = name;
            DateTime tmp = new DateTime();
            this.timestamp = tmp.Date;
        } 

        public override string ToString()
        {
            return String.Format("Folder: {0}", this.Name);
        }
    }
}
