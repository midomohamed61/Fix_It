import { motion } from "framer-motion";
import { Button } from "@/components/ui/Button/Button";
import { Pages } from "@/lib/config/constants";


export default function Success({ 
    // workerId, 
    // resetForm 
  }: { 
    workerId: string; 
    resetForm: () => void;
  }) {
    const containerVariants = {
        hidden: { opacity: 0, scale: 0.8 },
        visible: {
            opacity: 1,
            scale: 1,
            transition: {
                duration: 0.5,
                ease: "easeOut",
                when: "beforeChildren",
                staggerChildren: 0.1
            }
        }
    };

    const itemVariants = {
        hidden: { opacity: 0, y: 20 },
        visible: { opacity: 1, y: 0 }
    };

    return (
        <motion.div 
            className="form-section text-center"
            initial="hidden"
            animate="visible"
            variants={containerVariants}
        >
            <motion.div 
                className="success-icon w-24 h-24 bg-[#FEF3E2] rounded-full flex items-center justify-center mx-auto mb-6"
                variants={itemVariants}
            >
                <motion.div
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    transition={{ delay: 0.2, type: "spring", stiffness: 200 }}
                    className="text-5xl"
                >
                    ✅
                </motion.div>
            </motion.div>

            <motion.h2 
                className="text-3xl font-semibold text-[#3B6790] mb-4"
                variants={itemVariants}
            >
                Application Submitted Successfully!
            </motion.h2>

            <motion.p 
                className="text-[#4C7B8B] mb-8 max-w-md mx-auto"
                variants={itemVariants}
            >
                Thank you for submitting your application. We will review your information and get back to you shortly.
            </motion.p>

            <motion.div
                variants={itemVariants}
                whileHover={{ y: -2, boxShadow: "0 10px 15px -3px rgba(0, 0, 0, 0.1)" }}
                whileTap={{ scale: 0.98 }}
            >
                <Button
                    type="button"
                    onClick={() => window.location.href =`${Pages.LOGIN}`}
                    className="bg-[#EFB036] hover:bg-[#e0a030] text-[#23486A] font-medium py-3 px-8 rounded-lg transition-all shadow-md hover:shadow-lg"
                >
                    Submit New Application
                </Button>
            </motion.div>
        </motion.div>
    );
} 