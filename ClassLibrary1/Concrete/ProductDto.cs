using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ECommerceProject.Entities.Concrete
{
    public class ProductDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }

        public int CategoryId { get; set; } // <-- Bu satırı ekle

        public string CategoryName { get; set; }
        public string ParentCategoryName { get; set; }
        public string GrandParentCategoryName { get; set; }

        public string ImageUrl { get; set; }
        public string FullCategoryPath { get; set; }
    }
}
