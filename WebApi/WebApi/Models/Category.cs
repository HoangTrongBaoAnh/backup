using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models
{
    [Table("Categories")]
    public class Category
    {
        [Key]
        public int Id { get; set; }


        [Required]
        public string Name { get; set; }

        public virtual IEnumerable<Book> Books { set; get; }
    }
}
