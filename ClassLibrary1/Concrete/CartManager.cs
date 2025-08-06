using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using ECommerceProject.Entities.Concrete;
using ECommerceProject.Business.Abstract;
using ECommerceProject.Core.Helpers;

namespace ECommerceProject.Business.Concrete
{
    public class CartManager : ICartService
    {
        private const string CartSessionKey = "Cart";
        private readonly IProductService _productService;

        public CartManager(IProductService productService)
        {
            _productService = productService;
        }

        public List<CartItem> GetCartFromSession(ISession session)
        {
            if (session == null) throw new ArgumentNullException(nameof(session));

            var cartJson = session.GetString(CartSessionKey);
            if (string.IsNullOrEmpty(cartJson))
            {
                return new List<CartItem>();
            }

            var simpleCartItems = JsonSerializer.Deserialize<List<CartItem>>(cartJson) ?? new List<CartItem>();

            var fullCartItems = new List<CartItem>();
            foreach (var item in simpleCartItems)
            {
                var product = _productService.GetProductById(item.ProductId);
                if (product != null)
                {
                    fullCartItems.Add(new CartItem
                    {
                        ProductId = item.ProductId,
                        Quantity = item.Quantity,
                        Product = product,
                        UnitPrice = product.Price
                    });
                }
            }
            return fullCartItems;
        }

        public void SaveCartToSession(ISession session, List<CartItem> cart)
        {
            if (session == null) throw new ArgumentNullException(nameof(session));
            if (cart == null) throw new ArgumentNullException(nameof(cart));

            var itemsToSerialize = cart.Select(item => new CartItem
            {
                ProductId = item.ProductId,
                Quantity = item.Quantity
            }).ToList();

            var cartJson = JsonSerializer.Serialize(itemsToSerialize);
            session.SetString(CartSessionKey, cartJson);
        }

        public void AddToCart(List<CartItem> cart, Product product)
        {
            if (cart == null) throw new ArgumentNullException(nameof(cart));
            if (product == null) throw new ArgumentNullException(nameof(product));

            var item = cart.FirstOrDefault(x => x.ProductId == product.Id);
            if (item != null)
            {
                item.Quantity++;
            }
            else
            {
                cart.Add(new CartItem
                {
                    ProductId = product.Id,
                    Product = product,
                    Quantity = 1,
                    UnitPrice = product.Price
                });
            }
        }

        public void IncreaseQuantity(List<CartItem> cart, int productId)
        {
            if (cart == null) throw new ArgumentNullException(nameof(cart));

            var item = cart.FirstOrDefault(x => x.ProductId == productId);
            if (item != null)
            {
                item.Quantity++;
            }
        }

        public void DecreaseQuantity(List<CartItem> cart, int productId)
        {
            if (cart == null) throw new ArgumentNullException(nameof(cart));

            var item = cart.FirstOrDefault(x => x.ProductId == productId);
            if (item != null)
            {
                item.Quantity--;
                if (item.Quantity <= 0)
                {
                    cart.Remove(item);
                }
            }
        }

        public void ClearCart(ISession session)
        {
            if (session == null) throw new ArgumentNullException(nameof(session));
            session.Remove(CartSessionKey);
        }
    }
}
