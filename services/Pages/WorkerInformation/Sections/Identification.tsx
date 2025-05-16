import { Button } from "@/components/ui/Button/Button";
import { Input } from "@/components/ui/Form/Input";
import { Label } from "@/components/ui/Form/Label";
import { motion } from "framer-motion";

export default function Identification({ 
    formData, 
    errors, 
    handleChange, 
    prevSection, 
    nextSection 
}: {
    formData: {
      idType: string;
      idNumber: string;
      issueDate: string;
      expiryDate: string;
      issuingAuthority: string;
      issuingCountry: string;
    };
    errors: Record<string, string>;
    handleChange: (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => void;
    prevSection: () => void;
    nextSection: () => void;
}) {
    const containerVariants = {
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
    };

    const itemVariants = {
        hidden: { opacity: 0, y: 10 },
        visible: { opacity: 1, y: 0 }
    };

    return (
        <motion.div 
            className="form-section"
            initial="hidden"
            animate="visible"
            variants={containerVariants}
        >
            <motion.h2 
                className="text-2xl font-semibold text-[#23486A] mb-5 pb-2 border-b-2 border-[#EFB036]"
                variants={itemVariants}
            >
                Identification Details
            </motion.h2>
            
            <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="idType" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        ID Type*
                    </Label>
                    <select
                        id="idType"
                        name="idType"
                        value={formData.idType}
                        onChange={handleChange}
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] text-[#23486A] ${errors.idType ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    >
                        <option value="">Select ID Type</option>
                        <option value="passport">Passport</option>
                        <option value="national_id">National ID</option>
                        <option value="drivers_license">Driver&apos;s License</option>
                        <option value="residence_permit">Residence Permit</option>
                    </select>
                    {errors.idType && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.idType}
                        </motion.p>
                    )}
                </div>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="idNumber" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        ID Number*
                    </Label>
                    <Input
                        type="text"
                        id="idNumber"
                        name="idNumber"
                        value={formData.idNumber}
                        onChange={handleChange}
                        pattern="\d{14}"
                        maxLength={14}
                        inputMode="numeric"
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] text-[#23486A] ${errors.idNumber ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    />
                    {errors.idNumber && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.idNumber}
                        </motion.p>
                    )}
                </div>
            </motion.div>

            <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="issueDate" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Issue Date*
                    </Label>
                    <Input
                        type="date"
                        id="issueDate"
                        name="issueDate"
                        value={formData.issueDate}
                        onChange={handleChange}
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] text-[#23486A] ${errors.issueDate ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    />
                    {errors.issueDate && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.issueDate}
                        </motion.p>
                    )}
                </div>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="expiryDate" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Expiry Date*
                    </Label>
                    <Input
                        type="date"
                        id="expiryDate"
                        name="expiryDate"
                        value={formData.expiryDate}
                        onChange={handleChange}
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] text-[#23486A]  ${errors.expiryDate ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    />
                    {errors.expiryDate && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1 bg-amber-800"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.expiryDate}
                        </motion.p>
                    )}
                </div>
            </motion.div>

            <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="issuingAuthority" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Issuing Authority*
                    </Label>
                    <Input
                        type="text"
                        id="issuingAuthority"
                        name="issuingAuthority"
                        value={formData.issuingAuthority}
                        onChange={handleChange}
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] text-[#23486A] ${errors.issuingAuthority ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    />
                    {errors.issuingAuthority && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.issuingAuthority}
                        </motion.p>
                    )}
                </div>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="issuingCountry" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Issuing Country*
                    </Label>
                    <Input
                        type="text"
                        id="issuingCountry"
                        name="issuingCountry"
                        value={formData.issuingCountry}
                        onChange={handleChange}
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2]  text-[#23486A] ${errors.issuingCountry ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    />
                    {errors.issuingCountry && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.issuingCountry}
                        </motion.p>
                    )}
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
                        Next: Documentation
                    </Button>
                </motion.div>
            </motion.div>
        </motion.div>
    );
} 