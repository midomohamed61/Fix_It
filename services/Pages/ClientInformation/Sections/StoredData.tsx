import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { Button } from "@/components/ui/Button/Button";

interface StoredClientData {
    clientId: string;
    firstName: string;
    lastName: string;
    dob: string;
    gender: string;
    nationality: string;
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
    const [storedData, setStoredData] = useState<StoredClientData[]>([]);
    const [selectedClient, setSelectedClient] = useState<StoredClientData | null>(null);

    useEffect(() => {
        // Load all stored client data
        const loadStoredData = () => {
            if (typeof window !== 'undefined') {
                const allKeys = Object.keys(localStorage);
                const clientData = allKeys
                    .filter(key => key.startsWith('clientFormData_'))
                    .map(key => {
                        const data = JSON.parse(localStorage.getItem(key) || '{}');
                        return {
                            ...data,
                            clientId: key.replace('clientFormData_', '')
                        };
                    });
                setStoredData(clientData);
            }
        };

        loadStoredData();
    }, []);

    const formatDate = (dateString: string) => {
        if (!dateString) return 'Not specified';
        return new Date(dateString).toLocaleDateString();
    };

    const handleViewDetails = (client: StoredClientData) => {
        setSelectedClient(client);
    };

    const handleDelete = (clientId: string) => {
        if (typeof window !== 'undefined') {
            localStorage.removeItem(`clientFormData_${clientId}`);
            setStoredData(prev => prev.filter(client => client.clientId !== clientId));
            if (selectedClient?.clientId === clientId) {
                setSelectedClient(null);
            }
        }
    };

    return (
        <div className="min-h-screen bg-[#FEF3E2] p-8">
            <h1 className="text-3xl font-semibold text-[#23486A] mb-8">Stored Client Information</h1>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                {/* List of Clients */}
                <div className="bg-white rounded-xl shadow-lg p-6">
                    <h2 className="text-xl font-semibold text-[#EFB036] mb-4">Registered Clients</h2>
                    <div className="space-y-4">
                        {storedData.map((client) => (
                            <motion.div
                                key={client.clientId}
                                className="bg-[#FEF3E2] p-4 rounded-lg cursor-pointer hover:bg-[#f5e6d1] transition-colors"
                                whileHover={{ scale: 1.02 }}
                                onClick={() => handleViewDetails(client)}
                            >
                                <div className="flex justify-between items-center">
                                    <div>
                                        <h3 className="font-semibold text-[#23486A]">
                                            {client.firstName} {client.lastName}
                                        </h3>
                                        <p className="text-sm text-[#4C7B8B]">ID: {client.clientId}</p>
                                    </div>
                                    <Button
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handleDelete(client.clientId);
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

                {/* Client Details */}
                <div className="bg-white rounded-xl shadow-lg p-6">
                    <h2 className="text-xl font-semibold text-[#EFB036] mb-4">Client Details</h2>
                    {selectedClient ? (
                        <div className="space-y-6">
                            <div className="bg-[#FEF3E2] p-4 rounded-lg">
                                <h3 className="font-semibold text-[#23486A] mb-2">Personal Information</h3>
                                <p>Name: {selectedClient.firstName} {selectedClient.lastName}</p>
                                <p>Date of Birth: {formatDate(selectedClient.dob)}</p>
                                <p>Gender: {selectedClient.gender}</p>
                                <p>Nationality: {selectedClient.nationality}</p>
                            </div>

                            <div className="bg-[#FEF3E2] p-4 rounded-lg">
                                <h3 className="font-semibold text-[#23486A] mb-2">Contact Information</h3>
                                <p>Email: {selectedClient.email}</p>
                                <p>Phone: {selectedClient.phone}</p>
                                <p>Address: {selectedClient.address}</p>
                                <p>City: {selectedClient.city}</p>
                                <p>State: {selectedClient.state}</p>
                                <p>ZIP Code: {selectedClient.zipCode}</p>
                                <p>Country: {selectedClient.country}</p>
                            </div>

                            <div className="bg-[#FEF3E2] p-4 rounded-lg">
                                <h3 className="font-semibold text-[#23486A] mb-2">Identification</h3>
                                <p>ID Type: {selectedClient.idType}</p>
                                <p>ID Number: {selectedClient.idNumber}</p>
                                <p>Issue Date: {formatDate(selectedClient.issueDate)}</p>
                                <p>Expiry Date: {formatDate(selectedClient.expiryDate)}</p>
                                <p>Issuing Authority: {selectedClient.issuingAuthority}</p>
                                <p>Issuing Country: {selectedClient.issuingCountry}</p>
                            </div>

                            {selectedClient.profilePhoto && (
                                <div>
                                    <h3 className="text-lg font-semibold mb-2">Profile Photo</h3>
                                    <img 
                                        src={selectedClient.profilePhoto} 
                                        alt="Profile" 
                                        className="w-32 h-32 object-cover rounded-lg"
                                    />
                                </div>
                            )}
                            
                            {selectedClient.idFront && (
                                <div>
                                    <h3 className="text-lg font-semibold mb-2">ID Front</h3>
                                    <img 
                                        src={selectedClient.idFront} 
                                        alt="ID Front" 
                                        className="w-full max-w-md object-contain rounded-lg"
                                    />
                                </div>
                            )}
                            
                            {selectedClient.idBack && (
                                <div>
                                    <h3 className="text-lg font-semibold mb-2">ID Back</h3>
                                    <img 
                                        src={selectedClient.idBack} 
                                        alt="ID Back" 
                                        className="w-full max-w-md object-contain rounded-lg"
                                    />
                                </div>
                            )}
                            
                            {selectedClient.additionalDocs && selectedClient.additionalDocs.length > 0 && (
                                <div>
                                    <h3 className="text-lg font-semibold mb-2">Additional Documents</h3>
                                    <div className="grid grid-cols-2 gap-4">
                                        {selectedClient.additionalDocs.map((doc, index) => (
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
                        <p className="text-[#4C7B8B]">Select a client to view details</p>
                    )}
                </div>
            </div>
        </div>
    );
} 