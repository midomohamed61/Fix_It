'use client';
import { FaTrash, FaPlus, FaMinus } from 'react-icons/fa';
import { CustomImage } from '@/components/ui/Images/Image';
import { Button } from '../Button/Button';

interface CartItemProps {
  id: string;
  name: string;
  price: number;
  quantity: number;
  image: string;
  provider: string;
  duration: string;
}

interface ServiceCartItemProps {
  item: CartItemProps;
  onRemove: (id: string) => void;
  onQuantityChange: (id: string, change: number) => void;
}

export default function ServiceCartItem({ item, onRemove, onQuantityChange }: ServiceCartItemProps) {
  return (
    <div className="flex flex-col sm:flex-row items-start sm:items-center p-4 bg-white border border-[#4C7B8B]/20 rounded-lg shadow-md mb-4 gap-4">
      <div className="w-full sm:w-24 h-24 rounded-md overflow-hidden">
        <CustomImage 
          src={item.image} 
          alt={item.name} 
          width={96} 
          height={96} 
          rounded="md"
          className="w-full h-full"
          objectFit="cover"
        />
      </div>
      
      <div className="flex-1">
        <h3 className="text-lg font-semibold text-[#23486A]">{item.name}</h3>
        <p className="text-[#3B6790]">Provider: {item.provider}</p>
        <p className="text-[#4C7B8B] text-sm">Duration: {item.duration}</p>
        <p className="text-[#23486A] font-medium mt-1">${item.price.toFixed(2)}</p>
      </div>
      
      <div className="flex flex-col items-end gap-2 w-full sm:w-auto mt-2 sm:mt-0">
        <div className="flex items-center border border-[#4C7B8B]/20 rounded-lg">
          <Button 
            onClick={() => onQuantityChange(item.id, -1)}
            className="p-2 text-[#3B6790] hover:bg-[#F5EEDC] rounded-l-lg transition-colors"
            aria-label="Decrease quantity"
          >
            <FaMinus size={12} />
          </Button>
          <span className="px-4 py-1 text-[#23486A] font-medium">{item.quantity}</span>
          <Button 
            onClick={() => onQuantityChange(item.id, 1)}
            className="p-2 text-[#3B6790] hover:bg-[#F5EEDC] rounded-r-lg transition-colors"
            aria-label="Increase quantity"
          >
            <FaPlus size={12} />
          </Button>
        </div>
        
        <p className="text-[#3B6790] font-bold mt-1">
          Total: <span className="text-[#EFB036]">${(item.price * item.quantity).toFixed(2)}</span>
        </p>
        
        <Button
          onClick={() => onRemove(item.id)}
          className="flex items-center gap-1 text-sm text-[#4C7B8B] hover:text-[#23486A] transition-colors mt-1"
          aria-label="Remove item"
        >
          <FaTrash size={12} /> Remove
        </Button>
      </div>
    </div>
  );
}