using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace ECommerceProject.Entities.Concrete
{
    public class Product
    {
            public int Id { get; set; }
            public string Name { get; set; }
            public decimal Price { get; set; }
            public int Stock { get; set; }
            public string Description { get; set; }
        public string ImageUrl { get; set; } // Ürün fotoğrafının URL'si
        public int CategoryId { get; set; }
        [JsonIgnore]
        public virtual Category Category { get; set; }
        
    }
}
