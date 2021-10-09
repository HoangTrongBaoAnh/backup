using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WebApi.Models
{
    [Table("Books")]
    public class Book
    {
        [Key]
        public int Id { get; set; }


        [Required]
        public string Name { get; set; }

        public int CategoryID { set; get; }

        [ForeignKey("CategoryID")]
        public virtual Category Category { set; get; }

        public virtual IEnumerable<BookImage> BookImage { set; get; }
    }
}
