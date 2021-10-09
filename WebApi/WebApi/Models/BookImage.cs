using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WebApi.Models
{
    public class BookImage
    {
        [Key]
        public int Id { get; set; }


        [Required]
        public string Name { get; set; }

        public int BookId { set; get; }

        [NotMapped]
        public IFormFile ImageFile { get; set; }

        [ForeignKey("BookId")]
        public virtual Book Book { set; get; }
    }
}
