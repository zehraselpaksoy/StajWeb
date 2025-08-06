using System.Collections.Generic;

namespace ECommerceProject.Entities.Concrete
{
    public class Category
    {
        public Category()
        {
            SubCategories = new HashSet<Category>();
            Products = new HashSet<Product>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        
        public int? ParentId { get; set; } // Alt kategori için
        public virtual Category ParentCategory { get; set; }
        public virtual ICollection<Category> SubCategories { get; set; }

        public virtual ICollection<Product> Products { get; set; }
    }
}
