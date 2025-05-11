import { Button } from "@/components/ui/Button/Button";
import { Input } from "@/components/ui/Form/Input";
import { Label } from "@/components/ui/Form/Label";
import { motion } from "framer-motion";

export default function ContactDetails({ 
    formData, 
    errors, 
    handleChange, 
    prevSection, 
    nextSection 
  }: {
    formData: {
      email: string;
      phone: string;
      address: string;
      city: string;
      state: string;
      zipCode: string;
      country: string;
      alternateContact: string;
    };
    errors: Record<string, string>;
    handleChange: (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => void;
    prevSection: () => void;
    nextSection: () => void;
  }) {
    const itemVariants = {
        hidden: { opacity: 0, y: 10 },
        visible: { opacity: 1, y: 0 }
    };

    return (
        <motion.div 
            className="form-section"
            initial="hidden"
            animate="visible"
            variants={{
                hidden: { opacity: 0, y: 20 },
                visible: {
                    opacity: 1,
                    y: 0,
                    transition: {
                        duration: 0.5,
                        ease: "easeOut",
                        when: "beforeChildren",
                        staggerChildren: 0.1
                    }
                }
            }}
        >
          <motion.h2 
            className="text-2xl font-semibold text-[#23486A] mb-5 pb-2 border-b-2 border-[#EFB036]"
            variants={itemVariants}
          >
            Contact Details
          </motion.h2>
          
          <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
            <div className="w-full md:w-1/2 px-4 mb-5">
              <Label htmlFor="email" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                Email Address*
              </Label>
              <Input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.email ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                required
              />
              {errors.email && (
                <motion.p 
                  className="text-red-500 text-sm mt-1"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3 }}
                >
                  {errors.email}
                </motion.p>
              )}
            </div>
            <div className="w-full md:w-1/2 px-4 mb-5">
              <Label htmlFor="phone" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                Phone Number*
              </Label>
              <Input
                type="tel"
                id="phone"
                name="phone"
                value={formData.phone}
                onChange={handleChange}
                className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.phone ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                required
              />
              {errors.phone && (
                <motion.p 
                  className="text-red-500 text-sm mt-1"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3 }}
                >
                  {errors.phone}
                </motion.p>
              )}
            </div>
          </motion.div>
    
          <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
            <div className="w-full px-4 mb-5">
              <Label htmlFor="address" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                Address*
              </Label>
              <Input
                type="text"
                id="address"
                name="address"
                value={formData.address}
                onChange={handleChange}
                className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.address ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                required
              />
              {errors.address && (
                <motion.p 
                  className="text-red-500 text-sm mt-1"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3 }}
                >
                  {errors.address}
                </motion.p>
              )}
            </div>
          </motion.div>
    
          <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
            <div className="w-full md:w-1/3 px-4 mb-5">
              <Label htmlFor="city" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                City*
              </Label>
              <Input
                type="text"
                id="city"
                name="city"
                value={formData.city}
                onChange={handleChange}
                className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.city ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                required
              />
              {errors.city && (
                <motion.p 
                  className="text-red-500 text-sm mt-1"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3 }}
                >
                  {errors.city}
                </motion.p>
              )}
            </div>
            <div className="w-full md:w-1/3 px-4 mb-5">
              <Label htmlFor="state" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                State/Province*
              </Label>
              <Input
                type="text"
                id="state"
                name="state"
                value={formData.state}
                onChange={handleChange}
                className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.state ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                required
              />
              {errors.state && (
                <motion.p 
                  className="text-red-500 text-sm mt-1"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3 }}
                >
                  {errors.state}
                </motion.p>
              )}
            </div>
            <div className="w-full md:w-1/3 px-4 mb-5">
              <Label htmlFor="zipCode" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                Postal/Zip Code*
              </Label>
              <Input
                type="text"
                id="zipCode"
                name="zipCode"
                value={formData.zipCode}
                onChange={handleChange}
                className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.zipCode ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                required
              />
              {errors.zipCode && (
                <motion.p 
                  className="text-red-500 text-sm mt-1"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3 }}
                >
                  {errors.zipCode}
                </motion.p>
              )}
            </div>
          </motion.div>
    
          <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
            <div className="w-full md:w-1/2 px-4 mb-5">
              <Label htmlFor="country" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                Country*
              </Label>
              <Input
                type="text"
                id="country"
                name="country"
                value={formData.country}
                onChange={handleChange}
                className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.country ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                required
              />
              {errors.country && (
                <motion.p 
                  className="text-red-500 text-sm mt-1"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3 }}
                >
                  {errors.country}
                </motion.p>
              )}
            </div>
            <div className="w-full md:w-1/2 px-4 mb-5">
              <Label htmlFor="alternateContact" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                Alternate Contact
              </Label>
              <Input
                type="text"
                id="alternateContact"
                name="alternateContact"
                value={formData.alternateContact}
                onChange={handleChange}
                className="w-full p-3 border-2 border-[#4C7B8B] rounded-lg transition-all bg-[#FEF3E2] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
              />
            </div>
          </motion.div>
    
          <motion.div 
            className="flex justify-between mt-8"
            variants={itemVariants}
          >
            <motion.div
              whileHover={{ y: -2, boxShadow: "0 10px 15px -3px rgba(0, 0, 0, 0.1)" }}
              whileTap={{ scale: 0.98 }}
            >
              <Button
                type="button"
                onClick={prevSection}
                className="bg-transparent border-2 border-[#23486A] text-[#23486A] hover:bg-[#4C7B8B] hover:text-white font-medium py-3 px-6 rounded-lg transition-all shadow-md hover:shadow-lg"
              >
                Previous
              </Button>
            </motion.div>
            <motion.div
              whileHover={{ y: -2, boxShadow: "0 10px 15px -3px rgba(0, 0, 0, 0.1)" }}
              whileTap={{ scale: 0.98 }}
            >
              <Button
                type="button"
                onClick={nextSection}
                className="bg-[#EFB036] hover:bg-[#e0a030] text-[#23486A] font-medium py-3 px-6 rounded-lg transition-all shadow-md hover:shadow-lg"
              >
                Next: Identification
              </Button>
            </motion.div>
          </motion.div>
        </motion.div>
      );
    }