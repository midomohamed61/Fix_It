import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { Button } from "@/components/ui/Button/Button";

interface StoredWorkerData {
    workerId: string;
    firstName: string;
    lastName: string;
    dob: string;
    gender: string;
    nationality: string;
    occupation: string;
    email: string;
    phone: string;
    address: string;
    city: string;
    state: string;
    zipCode: string;
    country: string;
    idType: string;
    idNumber: string;
    issueDate: string;
    expiryDate: string;
    issuingAuthority: string;
    issuingCountry: string;
    profilePhoto: string | null; // base64 string
    idFront: string | null; // base64 string
    idBack: string | null; // base64 string
    additionalDocs: string[] | null; // array of base64 strings
    termsAccepted: boolean;
}

export default function StoredData() {
    const [storedData, setStoredData] = useState<StoredWorkerData[]>([]);
    const [selectedWorker, setSelectedWorker] = useState<StoredWorkerData | null>(null);

    useEffect(() => {
        // Load all stored worker data
        const loadStoredData = () => {
            if (typeof window !== 'undefined') {
                const allKeys = Object.keys(localStorage);
                const workerData = allKeys
                    .filter(key => key.startsWith('workerFormData_'))
                    .map(key => {
                        const data = JSON.parse(localStorage.getItem(key) || '{}');
                        return {
                            ...data,
                            workerId: key.replace('workerFormData_', '')
                        };
                    });
                setStoredData(workerData);
            }
        };

        loadStoredData();
    }, []);

    const formatDate = (dateString: string) => {
        if (!dateString) return 'Not specified';
        return new Date(dateString).toLocaleDateString();
    };

    const handleViewDetails = (worker: StoredWorkerData) => {
        setSelectedWorker(worker);
    };

    const handleDelete = (workerId: string) => {
        if (typeof window !== 'undefined') {
            localStorage.removeItem(`workerFormData_${workerId}`);
            setStoredData(prev => prev.filter(worker => worker.workerId !== workerId));
            if (selectedWorker?.workerId === workerId) {
                setSelectedWorker(null);
            }
        }
    };

    return (
        <div className="min-h-screen bg-[#FEF3E2] p-8">
            <h1 className="text-3xl font-semibold text-[#23486A] mb-8">Stored Worker Information</h1>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                {/* List of Workers */}
                <div className="bg-white rounded-xl shadow-lg p-6">
                    <h2 className="text-xl font-semibold text-[#EFB036] mb-4">Registered Workers</h2>
                    <div className="space-y-4">
                        {storedData.map((worker) => (
                            <motion.div
                                key={worker.workerId}
                                className="bg-[#FEF3E2] p-4 rounded-lg cursor-pointer hover:bg-[#f5e6d1] transition-colors"
                                whileHover={{ scale: 1.02 }}
                                onClick={() => handleViewDetails(worker)}
                            >
                                <div className="flex justify-between items-center">
                                    <div>
                                        <h3 className="font-semibold text-[#23486A]">
                                            {worker.firstName} {worker.lastName}
                                        </h3>
                                        <p className="text-sm text-[#4C7B8B]">ID: {worker.workerId}</p>
                                    </div>
                                    <Button
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handleDelete(worker.workerId);
                                        }}
                                        className="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded"
                                    >
                                        Delete
                                    </Button>
                                </div>
                            </motion.div>
                        ))}
                    </div>
                </div>

                {/* Worker Details */}
                <div className="bg-white rounded-xl shadow-lg p-6">
                    <h2 className="text-xl font-semibold text-[#EFB036] mb-4">Worker Details</h2>
                    {selectedWorker ? (
                        <div className="space-y-6">
                            <div className="bg-[#FEF3E2] p-4 rounded-lg">
                                <h3 className="font-semibold text-[#23486A] mb-2">Personal Information</h3>
                                <p>Name: {selectedWorker.firstName} {selectedWorker.lastName}</p>
                                <p>Date of Birth: {formatDate(selectedWorker.dob)}</p>
                                <p>Gender: {selectedWorker.gender}</p>
                                <p>Nationality: {selectedWorker.nationality}</p>
                                <p>Occupation: {selectedWorker.occupation}</p>
                            </div>

                            <div className="bg-[#FEF3E2] p-4 rounded-lg">
                                <h3 className="font-semibold text-[#23486A] mb-2">Contact Information</h3>
                                <p>Email: {selectedWorker.email}</p>
                                <p>Phone: {selectedWorker.phone}</p>
                                <p>Address: {selectedWorker.address}</p>
                                <p>City: {selectedWorker.city}</p>
                                <p>State: {selectedWorker.state}</p>
                                <p>ZIP Code: {selectedWorker.zipCode}</p>
                                <p>Country: {selectedWorker.country}</p>
                            </div>

                            <div className="bg-[#FEF3E2] p-4 rounded-lg">
                                <h3 className="font-semibold text-[#23486A] mb-2">Identification</h3>
                                <p>ID Type: {selectedWorker.idType}</p>
                                <p>ID Number: {selectedWorker.idNumber}</p>
                                <p>Issue Date: {formatDate(selectedWorker.issueDate)}</p>
                                <p>Expiry Date: {formatDate(selectedWorker.expiryDate)}</p>
                                <p>Issuing Authority: {selectedWorker.issuingAuthority}</p>
                                <p>Issuing Country: {selectedWorker.issuingCountry}</p>
                            </div>

                            {selectedWorker.profilePhoto && (
                                <div>
                                    <h3 className="text-lg font-semibold mb-2">Profile Photo</h3>
                                    <img 
                                        src={selectedWorker.profilePhoto} 
                                        alt="Profile" 
                                        className="w-32 h-32 object-cover rounded-lg"
                                    />
                                </div>
                            )}
                            
                            {selectedWorker.idFront && (
                                <div>
                                    <h3 className="text-lg font-semibold mb-2">ID Front</h3>
                                    <img 
                                        src={selectedWorker.idFront} 
                                        alt="ID Front" 
                                        className="w-full max-w-md object-contain rounded-lg"
                                    />
                                </div>
                            )}
                            
                            {selectedWorker.idBack && (
                                <div>
                                    <h3 className="text-lg font-semibold mb-2">ID Back</h3>
                                    <img 
                                        src={selectedWorker.idBack} 
                                        alt="ID Back" 
                                        className="w-full max-w-md object-contain rounded-lg"
                                    />
                                </div>
                            )}
                            
                            {selectedWorker.additionalDocs && selectedWorker.additionalDocs.length > 0 && (
                                <div>
                                    <h3 className="text-lg font-semibold mb-2">Additional Documents</h3>
                                    <div className="grid grid-cols-2 gap-4">
                                        {selectedWorker.additionalDocs.map((doc, index) => (
                                            <img 
                                                key={index}
                                                src={doc} 
                                                alt={`Additional Document ${index + 1}`} 
                                                className="w-full object-contain rounded-lg"
                                            />
                                        ))}
                                    </div>
                                </div>
                            )}
                        </div>
                    ) : (
                        <p className="text-[#4C7B8B]">Select a worker to view details</p>
                    )}
                </div>
            </div>
        </div>
    );
} 