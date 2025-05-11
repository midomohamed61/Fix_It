import { motion } from "framer-motion";
import { Input } from "@/components/ui/Form/Input";
import { Label } from "@/components/ui/Form/Label";
import { Button } from "@/components/ui/Button/Button";

export default function PersonalInformation({ 
    formData, 
    errors, 
    handleChange, 
    nextSection 
}: {
    formData: {
      firstName: string;
      lastName: string;
      dob: string;
      gender: string;
      nationality: string;
      occupation: string;
    };
    errors: Record<string, string>;
    handleChange: (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => void;
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
                Personal Information
            </motion.h2>
            
            <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="firstName" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        First Name*
                    </Label>
                    <Input
                        type="text"
                        id="firstName"
                        name="firstName"
                        value={formData.firstName}
                        onChange={handleChange}
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.firstName ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    />
                    {errors.firstName && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.firstName}
                        </motion.p>
                    )}
                </div>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="lastName" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Last Name*
                    </Label>
                    <Input
                        type="text"
                        id="lastName"
                        name="lastName"
                        value={formData.lastName}
                        onChange={handleChange}
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.lastName ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    />
                    {errors.lastName && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.lastName}
                        </motion.p>
                    )}
                </div>
            </motion.div>
    
            <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="dob" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Date of Birth*
                    </Label>
                    <Input
                        type="date"
                        id="dob"
                        name="dob"
                        value={formData.dob}
                        onChange={handleChange}
                        className={`w-full p-3 border-2 rounded-lg transition-all bg-[#FEF3E2] ${errors.dob ? 'border-red-500 animate-shake' : 'border-[#4C7B8B] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent'}`}
                        required
                    />
                    {errors.dob && (
                        <motion.p 
                            className="text-red-500 text-sm mt-1"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.3 }}
                        >
                            {errors.dob}
                        </motion.p>
                    )}
                </div>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="gender" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Gender
                    </Label>
                    <select
                        id="gender"
                        name="gender"
                        value={formData.gender}
                        onChange={handleChange}
                        className="w-full p-3 border-2 border-[#4C7B8B] bg-[#FEF3E2] rounded-lg transition-all hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
                    >
                        <option value="">Select</option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="nonbinary">Non-binary</option>
                        <option value="other">Other</option>
                        <option value="prefer">Prefer not to say</option>
                    </select>
                </div>
            </motion.div>
    
            <motion.div className="flex flex-wrap -mx-4 mb-5" variants={itemVariants}>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="nationality" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Nationality
                    </Label>
                    <Input
                        type="text"
                        id="nationality"
                        name="nationality"
                        value={formData.nationality}
                        onChange={handleChange}
                        className="w-full p-3 border-2 border-[#4C7B8B] rounded-lg transition-all bg-[#FEF3E2] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
                    />
                </div>
                <div className="w-full md:w-1/2 px-4 mb-5">
                    <Label htmlFor="occupation" className="block font-medium mb-2" style={{ color: '#23486A' }}>
                        Occupation
                    </Label>
                    <Input
                        type="text"
                        id="occupation"
                        name="occupation"
                        value={formData.occupation}
                        onChange={handleChange}
                        className="w-full p-3 border-2 border-[#4C7B8B] rounded-lg transition-all bg-[#FEF3E2] hover:border-[#EFB036] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
                    />
                </div>
            </motion.div>
    
            <motion.div 
                className="flex justify-end mt-8"
                variants={itemVariants}
            >
                <motion.div
                    whileHover={{ y: -2, boxShadow: "0 10px 15px -3px rgba(0, 0, 0, 0.1)" }}
                    whileTap={{ scale: 0.98 }}
                >
                    <Button
                        type="button"
                        onClick={nextSection}
                        className="bg-[#EFB036] hover:bg-[#e0a030] text-[#23486A] font-medium py-3 px-6 rounded-lg transition-all shadow-md hover:shadow-lg"
                    >
                        Next: Contact Details
                    </Button>
                </motion.div>
            </motion.div>
        </motion.div>
    );
}