using ECommerceProject.Entities.Concrete;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;

namespace ECommerceProject.Business.Abstract
{
    public interface ICartService
    {
        List<CartItem> GetCartFromSession(ISession session);
        void SaveCartToSession(ISession session, List<CartItem> cart);
        void AddToCart(List<CartItem> cart, Product product);
        void IncreaseQuantity(List<CartItem> cart, int productId);
        void DecreaseQuantity(List<CartItem> cart, int productId);
        void ClearCart(ISession session);
    }
}
