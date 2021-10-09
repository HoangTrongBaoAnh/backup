using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace WebApi.Models.DTOs.Requests
{
    public class ChangeRoleRequest
    {
        [Required]
        public string Role { get; set; }
    }
}
