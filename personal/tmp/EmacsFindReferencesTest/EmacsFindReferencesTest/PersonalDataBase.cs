using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmacsFindReferencesTest
{
    abstract class PersonalDataBase : IGivePersonalData
    {
        public Namespace namesp;
        public Folder folder;

        public string GetFolder()
        {
            return this.folder.ToString();
        }

        public string GetFullName()
        {
            return String.Format("{0}, {1}", this.GetFolder(), this.GetNamespace());
        }

        public string GetNamespace()
        {
            return this.namesp.ToString();
        }
    }
}
