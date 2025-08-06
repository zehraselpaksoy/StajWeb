using System;
using System.Text.Json.Serialization; // [JsonIgnore] için

namespace ECommerceProject.Entities.Concrete
{
    public class CartItem
    {
        public int Id { get; set; }
        public int? UserId { get; set; }
        public string SessionId { get; set; }
        public int ProductId { get; set; }

        [JsonIgnore] // Product objesinin serileştirme sorunlarını önlemek için
        public virtual Product Product { get; set; }

        public int Quantity { get; set; }

        // BURADAKİ DEĞİŞİKLİK ÇOK ÖNEMLİ: UnitPrice'ı atanabilir bir özellik yaptık
        public decimal UnitPrice { get; set; }

        // TotalPrice'ı UnitPrice ve Quantity'ye göre hesaplamaya devam ediyoruz
        [JsonIgnore] // TotalPrice'ı session'a kaydetmeye gerek yok, her zaman hesaplanabilir
        public decimal TotalPrice => UnitPrice * Quantity;

        public DateTime CreatedAt { get; set; } = DateTime.Now;

        [JsonIgnore] // User objesinin serileştirme sorunlarını önlemek için
        public virtual User User { get; set; }
    }
}
