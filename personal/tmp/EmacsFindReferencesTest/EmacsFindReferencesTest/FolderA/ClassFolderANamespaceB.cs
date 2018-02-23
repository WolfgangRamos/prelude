using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmacsFindReferencesTest.FolderB
{
    class ClassFolderANamespaceB : PersonalDataBase
    {
        public ClassFolderANamespaceB()
        {
            this.folder = new Folder("A");
            this.namesp = new Namespace("B");
        }
    }
}
