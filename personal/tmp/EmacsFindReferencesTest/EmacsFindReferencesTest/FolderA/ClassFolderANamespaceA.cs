using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmacsFindReferencesTest.FolderA
{
    class ClassFolderANamespaceA : PersonalDataBase
    {
        public ClassFolderANamespaceA()
        {
            this.folder = new Folder("A");
            this.namesp = new Namespace("A");
        }
    }
}
