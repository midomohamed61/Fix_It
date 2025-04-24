// pages/CartPage.tsx
'use client';
import { useState, useEffect } from 'react';
import { Button } from '@/components/ui/Button/Button';
import { LoadingSkeleton } from '@/components/ui/LoadingSkeleton';
import ServiceCartItem from '@/components/ui/cart/CartItem';
import { useCart } from '@/context/CartContext';

export default function ServiceCartPage() {
  const { cartItems, removeFromCart, updateQuantity } = useCart();
  const [isLoading, setIsLoading] = useState(true);
  const [promoCode, setPromoCode] = useState('');
  const [discount, setDiscount] = useState(0);
  const [promoError, setPromoError] = useState('');
  const [promoSuccess, setPromoSuccess] = useState('');

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsLoading(false);
    }, 1000);
    return () => clearTimeout(timer);
  }, []);

  const handleRemove = (id: string) => {
    removeFromCart(id);
  };

  const handleQuantityChange = (id: string, change: number) => {
    updateQuantity(id, change);
  };

  const applyPromoCode = () => {
    if (promoCode.toLowerCase() === 'first10') {
      setDiscount(10);
      setPromoSuccess('Promo code applied successfully!');
      setPromoError('');
    } else {
      setDiscount(0);
      setPromoError('Invalid promo code');
      setPromoSuccess('');
    }
  };

  const subtotal = cartItems.reduce((sum, item) => sum + item.price * item.quantity, 0);
  const serviceFee = subtotal * 0.05; 
  const discountAmount = (subtotal * discount) / 100;
  const totalPrice = subtotal + serviceFee - discountAmount;

  const CartSkeleton = () => (
    <div className="flex flex-col gap-4">
      {[1, 2].map((item) => (
        <div key={item} className="flex flex-col sm:flex-row items-start sm:items-center p-4 bg-white border border-[#4C7B8B]/10 rounded-lg shadow-md mb-4 gap-4">
          <LoadingSkeleton className="w-full sm:w-24 h-24 rounded-md" />
          <div className="flex-1 w-full">
            <LoadingSkeleton className="h-6 w-3/4 mb-2" />
            <LoadingSkeleton className="h-4 w-1/2 mb-2" />
            <LoadingSkeleton className="h-4 w-1/3 mb-2" />
            <LoadingSkeleton className="h-5 w-1/4" />
          </div>
          <div className="flex flex-col items-end gap-2 w-full sm:w-auto">
            <LoadingSkeleton className="h-8 w-28 mb-2" />
            <LoadingSkeleton className="h-5 w-24 mb-2" />
            <LoadingSkeleton className="h-4 w-16" />
          </div>
        </div>
      ))}
    </div>
  );

  return (
    <div className="min-h-screen bg-amber-50 flex flex-col">
      <section className="flex-1 p-4 sm:p-6 max-w-6xl mx-auto w-full">
        {isLoading ? (
          <CartSkeleton />
        ) : cartItems.length === 0 ? (
          <div className="text-center py-12 bg-white rounded-lg shadow-md">
            <div className="flex justify-center mb-4">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" className="w-16 h-16 text-[#4C7B8B]" fill="none" stroke="currentColor" strokeWidth="2">
                <path strokeLinecap="round" strokeLinejoin="round" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
            </div>
            <h2 className="text-xl font-bold text-[#23486A]">Your cart is empty</h2>
            <p className="text-[#4C7B8B] mt-2 mb-6">Looks like you haven&apos;t added any services yet</p>
            <Button className="px-6 py-3 bg-[#EFB036] text-[#23486A] font-semibold rounded-lg hover:bg-[#d89e2e] transition-colors">
              Browse Services
            </Button>
          </div>
        ) : (
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div className="lg:col-span-2">
              <h2 className="text-xl font-bold text-[#23486A] mb-4">Service Items ({cartItems.reduce((sum, item) => sum + item.quantity, 0)})</h2>
              
              <div className="space-y-4">
                {cartItems.map((item) => (
                  <ServiceCartItem 
                    key={item.id} 
                    item={item} 
                    onRemove={handleRemove}
                    onQuantityChange={handleQuantityChange}
                  />
                ))}
              </div>
            </div>
            
            <div className="lg:col-span-1">
              <div className="bg-white p-6 rounded-lg shadow-md border border-[#4C7B8B]/10 sticky top-6">
                <h2 className="text-xl font-bold text-[#23486A] mb-4">Order Summary</h2>
                
                <div className="space-y-3 text-[#3B6790]">
                  <div className="flex justify-between">
                    <span>Subtotal</span>
                    <span>${subtotal.toFixed(2)}</span>
                  </div>
                  <div className="flex justify-between">
                    <span>Service Fee</span>
                    <span>${serviceFee.toFixed(2)}</span>
                  </div>
                  {discount > 0 && (
                    <div className="flex justify-between text-green-600">
                      <span>Discount ({discount}%)</span>
                      <span>-${discountAmount.toFixed(2)}</span>
                    </div>
                  )}
                  <div className="border-t border-[#4C7B8B]/20 pt-3 mt-3"></div>
                  <div className="flex justify-between font-bold text-lg text-[#23486A]">
                    <span>Total</span>
                    <span>${totalPrice.toFixed(2)}</span>
                  </div>
                </div>
                
                <div className="mt-6">
                  <label className="block text-[#23486A] font-medium mb-2">Promo Code</label>
                  <div className="flex gap-2">
                    <input
                      type="text"
                      value={promoCode}
                      onChange={(e) => setPromoCode(e.target.value)}
                      placeholder="Enter promo code"
                      className="flex-1 px-3 py-2 border border-[#4C7B8B]/30 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#EFB036]/50"
                    />
                    <Button 
                      onClick={applyPromoCode}
                      className="px-4 py-2 bg-[#3B6790] text-white rounded-lg hover:bg-[#23486A] transition-colors"
                    >
                      Apply
                    </Button>
                  </div>
                  {promoError && <p className="text-red-500 text-sm mt-1">{promoError}</p>}
                  {promoSuccess && <p className="text-green-600 text-sm mt-1">{promoSuccess}</p>}
                  <div className="text-sm text-[#4C7B8B] mt-2">Try code: &quot;FIRST10&quot; for 10% off</div>
                </div>
                
                <Button className="w-full mt-6 py-3 bg-[#EFB036] text-[#23486A] font-bold rounded-lg hover:bg-[#d89e2e] transition-colors">
                  Proceed to Checkout
                </Button>
                
                <div className="mt-6 text-sm text-[#4C7B8B] text-center">
                  <p>Need help with your order?</p>
                  <a href="#" className="text-[#3B6790] hover:underline">Contact Support</a>
                </div>
              </div>
            </div>
          </div>
        )}
      </section>
    </div>
  );
}