using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApi.Configuration
{
    public class AutResult
    {
        public string Token { get; set; }
        public bool Success { get; set; }

        public List<string> Erorrs { get; set; }
    }
}
