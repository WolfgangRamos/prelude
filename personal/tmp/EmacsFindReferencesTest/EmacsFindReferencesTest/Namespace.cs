using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmacsFindReferencesTest
{
    class Namespace
    {
        public string Name { get; set; }

        public Namespace(string name)
        {
            this.Name = name;
        }

        public override string ToString()
        {
            return String.Format("Namspace: {0}", this.Name);
        }
    }
}
