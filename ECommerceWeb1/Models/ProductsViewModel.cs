using System.Collections.Generic;
using ECommerceProject.Business.Concrete; // ProductDto
using ECommerceProject.Entities.Concrete; // Category, CartItem

namespace ECommerceWeb1.Web.Models
{
    public class ProductsViewModel
    {
        public List<Category> Categories { get; set; }
        public List<ProductDto> Products { get; set; }
        public int? SelectedCategoryId { get; set; }
        public List<int> FavoriteProductIds { get; set; } = new List<int>();

        // Sepet için ekle
        public List<CartItem>? Cart { get; set; }

    }
}
