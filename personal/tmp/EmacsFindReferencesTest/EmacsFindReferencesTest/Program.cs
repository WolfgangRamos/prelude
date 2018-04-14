using EmacsFindReferencesTest.FolderA;
using EmacsFindReferencesTest.FolderB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmacsFindReferencesTest
{
    class Program
    {
        static void Main(string[] args)
        {
            ClassFolderANamespaceA a = new ClassFolderANamespaceA();
            ClassFolderANamespaceB b = new ClassFolderANamespaceB();
        }
    }
}
