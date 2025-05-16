"use client";

import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/Button/Button';
import { useRouter } from 'next/navigation';
import { FaUser, FaIdCard, FaMapMarkerAlt, FaPhone, FaArrowLeft } from 'react-icons/fa';

interface ClientData {
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
    profilePhoto: string | null;
    idFront: string | null;
    idBack: string | null;
    additionalDocs: string[] | null;
    termsAccepted: boolean;
}

const SettingsPage = () => {
    const [clientData, setClientData] = useState<ClientData | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [isEditing, setIsEditing] = useState(false);
    const [editedData, setEditedData] = useState<Partial<ClientData>>({});
    const router = useRouter();

    useEffect(() => {
        const loadClientData = () => {
            try {
                if (typeof window !== 'undefined') {
                    const allKeys = Object.keys(localStorage);
                    const clientKeys = allKeys.filter(key => key.startsWith('clientFormData_'));
                    
                    if (clientKeys.length > 0) {
                        const latestKey = clientKeys[clientKeys.length - 1];
                        const data = JSON.parse(localStorage.getItem(latestKey) || '{}');
                        setClientData({
                            ...data,
                            clientId: latestKey.replace('clientFormData_', '')
                        });
                        setEditedData(data);
                    } else {
                        setError('No client data found');
                    }
                }
            } catch (err) {
                setError('Error loading client data');
                console.error('Error loading client data:', err);
            } finally {
                setIsLoading(false);
            }
        };

        loadClientData();
    }, []);

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { name, value } = e.target;
        setEditedData(prev => ({
            ...prev,
            [name]: value
        }));
    };

    const handleSave = () => {
        if (!clientData) return;

        try {
            // Save to localStorage
            const key = `clientFormData_${clientData.clientId}`;
            localStorage.setItem(key, JSON.stringify({
                ...clientData,
                ...editedData
            }));

            // Update state
            setClientData(prev => prev ? { ...prev, ...editedData } : null);
            setIsEditing(false);

            // Show success message
            alert('Changes saved successfully!');
        } catch (err) {
            setError('Error saving changes');
            console.error('Error saving changes:', err);
        }
    };

    if (isLoading) {
        return (
            <div className="min-h-screen bg-[#23486A] text-[#F5EEDC] p-6">
                <div className="animate-pulse space-y-4">
                    <div className="h-8 bg-[#3B6790] rounded w-1/4"></div>
                    <div className="space-y-2">
                        <div className="h-4 bg-[#3B6790] rounded"></div>
                        <div className="h-4 bg-[#3B6790] rounded w-5/6"></div>
                    </div>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className="min-h-screen bg-[#23486A] text-[#F5EEDC] p-6 flex items-center justify-center">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="bg-[#3B6790] rounded-xl p-6 max-w-md w-full text-center"
                >
                    <h2 className="text-xl font-semibold mb-4">Error</h2>
                    <p className="mb-6">{error}</p>
                    <Button 
                        className="bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] font-medium"
                        onClick={() => router.push('/client/dashboard')}
                    >
                        Back to Dashboard
                    </Button>
                </motion.div>
            </div>
        );
    }

    if (!clientData) {
        return (
            <div className="min-h-screen bg-[#23486A] text-[#F5EEDC] p-6 flex items-center justify-center">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="bg-[#3B6790] rounded-xl p-6 max-w-md w-full text-center"
                >
                    <h2 className="text-xl font-semibold mb-4">No Client Data Found</h2>
                    <p className="mb-6">Please complete the registration form first.</p>
                    <Button 
                        className="bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] font-medium"
                        onClick={() => router.push('/services/client-information')}
                    >
                        Go to Registration
                    </Button>
                </motion.div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-[#23486A] text-[#F5EEDC] p-6">
            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                className="max-w-4xl mx-auto"
            >
                <motion.button
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    onClick={() => router.back()}
                    className="mb-6 flex items-center space-x-2 px-4 py-2 bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] rounded-lg font-medium transition-colors duration-200"
                >
                    <FaArrowLeft className="transform transition-transform group-hover:-translate-x-1" />
                    <span>Back</span>
                </motion.button>

                <div className="flex justify-between items-center mb-8">
                    <h1 className="text-3xl font-bold text-[#EFB036]">Settings</h1>
                    <div className="space-x-4">
                        {isEditing ? (
                            <>
                                <Button
                                    className="bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] font-medium"
                                    onClick={handleSave}
                                >
                                    Save Changes
                                </Button>
                                <Button
                                    className="bg-[#4C7B8B] hover:bg-[#3f6673] text-[#F5EEDC] font-medium"
                                    onClick={() => {
                                        setEditedData(clientData);
                                        setIsEditing(false);
                                    }}
                                >
                                    Cancel
                                </Button>
                            </>
                        ) : (
                            <Button
                                className="bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] font-medium"
                                onClick={() => setIsEditing(true)}
                            >
                                Edit Information
                            </Button>
                        )}
                    </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {/* Personal Information */}
                    <motion.div
                        initial={{ opacity: 0, x: -20 }}
                        animate={{ opacity: 1, x: 0 }}
                        className="bg-[#3B6790] rounded-xl p-6"
                    >
                        <h2 className="text-xl font-semibold mb-4 flex items-center">
                            <FaUser className="mr-2" /> Personal Information
                        </h2>
                        <div className="space-y-4">
                            <div>
                                <label className="block text-sm mb-1">First Name</label>
                                <input
                                    type="text"
                                    name="firstName"
                                    value={editedData.firstName || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Last Name</label>
                                <input
                                    type="text"
                                    name="lastName"
                                    value={editedData.lastName || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Date of Birth</label>
                                <input
                                    type="date"
                                    name="dob"
                                    value={editedData.dob || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Gender</label>
                                <select
                                    name="gender"
                                    value={editedData.gender || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                >
                                    <option value="">Select Gender</option>
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                    <option value="other">Other</option>
                                </select>
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Nationality</label>
                                <input
                                    type="text"
                                    name="nationality"
                                    value={editedData.nationality || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                        </div>
                    </motion.div>

                    {/* Contact Information */}
                    <motion.div
                        initial={{ opacity: 0, x: 20 }}
                        animate={{ opacity: 1, x: 0 }}
                        className="bg-[#3B6790] rounded-xl p-6"
                    >
                        <h2 className="text-xl font-semibold mb-4 flex items-center">
                            <FaPhone className="mr-2" /> Contact Information
                        </h2>
                        <div className="space-y-4">
                            <div>
                                <label className="block text-sm mb-1">Email</label>
                                <input
                                    type="email"
                                    name="email"
                                    value={editedData.email || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Phone</label>
                                <input
                                    type="tel"
                                    name="phone"
                                    value={editedData.phone || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                        </div>
                    </motion.div>

                    {/* Address Information */}
                    <motion.div
                        initial={{ opacity: 0, x: -20 }}
                        animate={{ opacity: 1, x: 0 }}
                        className="bg-[#3B6790] rounded-xl p-6"
                    >
                        <h2 className="text-xl font-semibold mb-4 flex items-center">
                            <FaMapMarkerAlt className="mr-2" /> Address Information
                        </h2>
                        <div className="space-y-4">
                            <div>
                                <label className="block text-sm mb-1">Address</label>
                                <input
                                    type="text"
                                    name="address"
                                    value={editedData.address || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">City</label>
                                <input
                                    type="text"
                                    name="city"
                                    value={editedData.city || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">State</label>
                                <input
                                    type="text"
                                    name="state"
                                    value={editedData.state || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">ZIP Code</label>
                                <input
                                    type="text"
                                    name="zipCode"
                                    value={editedData.zipCode || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Country</label>
                                <input
                                    type="text"
                                    name="country"
                                    value={editedData.country || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                        </div>
                    </motion.div>

                    {/* ID Information */}
                    <motion.div
                        initial={{ opacity: 0, x: 20 }}
                        animate={{ opacity: 1, x: 0 }}
                        className="bg-[#3B6790] rounded-xl p-6"
                    >
                        <h2 className="text-xl font-semibold mb-4 flex items-center">
                            <FaIdCard className="mr-2" /> ID Information
                        </h2>
                        <div className="space-y-4">
                            <div>
                                <label className="block text-sm mb-1">ID Type</label>
                                <select
                                    name="idType"
                                    value={editedData.idType || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                >
                                    <option value="">Select ID Type</option>
                                    <option value="passport">Passport</option>
                                    <option value="national_id">National ID</option>
                                    <option value="driver_license">Driver&apos;s License</option>
                                </select>
                            </div>
                            <div>
                                <label className="block text-sm mb-1">ID Number</label>
                                <input
                                    type="text"
                                    name="idNumber"
                                    value={editedData.idNumber || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Issue Date</label>
                                <input
                                    type="date"
                                    name="issueDate"
                                    value={editedData.issueDate || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Expiry Date</label>
                                <input
                                    type="date"
                                    name="expiryDate"
                                    value={editedData.expiryDate || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Issuing Authority</label>
                                <input
                                    type="text"
                                    name="issuingAuthority"
                                    value={editedData.issuingAuthority || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                            <div>
                                <label className="block text-sm mb-1">Issuing Country</label>
                                <input
                                    type="text"
                                    name="issuingCountry"
                                    value={editedData.issuingCountry || ''}
                                    onChange={handleInputChange}
                                    disabled={!isEditing}
                                    className="w-full bg-[#23486A] rounded-lg p-2 text-[#F5EEDC] disabled:opacity-50"
                                />
                            </div>
                        </div>
                    </motion.div>

                    {/* Images Section */}
                    <motion.div
                        initial={{ opacity: 0, x: 20 }}
                        animate={{ opacity: 1, x: 0 }}
                        className="bg-[#3B6790] rounded-xl p-6"
                    >
                        <h2 className="text-xl font-semibold mb-4 flex items-center">
                            <FaIdCard className="mr-2" /> Images 
                        </h2>
                        <div className="space-y-6">
                            {/* Profile Photo */}
                            <div>
                                <label className="block text-sm mb-2">Profile Photo</label>
                                <div className="flex items-center space-x-4">
                                    {editedData.profilePhoto ? (
                                        <img 
                                            src={editedData.profilePhoto} 
                                            alt="Profile" 
                                            className="w-24 h-24 rounded-full object-cover border-2 border-[#EFB036]"
                                        />
                                    ) : (
                                        <div className="w-24 h-24 rounded-full bg-[#23486A] flex items-center justify-center">
                                            <FaUser size={32} className="text-[#EFB036]" />
                                        </div>
                                    )}
                                    {isEditing && (
                                        <input
                                            type="file"
                                            accept="image/*"
                                            onChange={(e) => {
                                                const file = e.target.files?.[0];
                                                if (file) {
                                                    const reader = new FileReader();
                                                    reader.onloadend = () => {
                                                        setEditedData(prev => ({
                                                            ...prev,
                                                            profilePhoto: reader.result as string
                                                        }));
                                                    };
                                                    reader.readAsDataURL(file);
                                                }
                                            }}
                                            className="hidden"
                                            id="profilePhoto"
                                        />
                                    )}
                                    {isEditing && (
                                        <label 
                                            htmlFor="profilePhoto"
                                            className="px-4 py-2 bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] rounded-lg cursor-pointer"
                                        >
                                            Change Photo
                                        </label>
                                    )}
                                </div>
                            </div>

                            {/* ID Documents */}
                            <div className="grid grid-cols-2 gap-4">
                                <div>
                                    <label className="block text-sm mb-2">ID Front</label>
                                    <div className="relative">
                                        {editedData.idFront ? (
                                            <img 
                                                src={editedData.idFront} 
                                                alt="ID Front" 
                                                className="w-full h-32 object-cover rounded-lg border-2 border-[#EFB036]"
                                            />
                                        ) : (
                                            <div className="w-full h-32 rounded-lg bg-[#23486A] flex items-center justify-center">
                                                <FaIdCard size={32} className="text-[#EFB036]" />
                                            </div>
                                        )}
                                        {isEditing && (
                                            <>
                                                <input
                                                    type="file"
                                                    accept="image/*"
                                                    onChange={(e) => {
                                                        const file = e.target.files?.[0];
                                                        if (file) {
                                                            const reader = new FileReader();
                                                            reader.onloadend = () => {
                                                                setEditedData(prev => ({
                                                                    ...prev,
                                                                    idFront: reader.result as string
                                                                }));
                                                            };
                                                            reader.readAsDataURL(file);
                                                        }
                                                    }}
                                                    className="hidden"
                                                    id="idFront"
                                                />
                                                <label 
                                                    htmlFor="idFront"
                                                    className="absolute bottom-2 right-2 px-3 py-1 bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] rounded-lg cursor-pointer text-sm"
                                                >
                                                    Change
                                                </label>
                                            </>
                                        )}
                                    </div>
                                </div>
                                <div>
                                    <label className="block text-sm mb-2">ID Back</label>
                                    <div className="relative">
                                        {editedData.idBack ? (
                                            <img 
                                                src={editedData.idBack} 
                                                alt="ID Back" 
                                                className="w-full h-32 object-cover rounded-lg border-2 border-[#EFB036]"
                                            />
                                        ) : (
                                            <div className="w-full h-32 rounded-lg bg-[#23486A] flex items-center justify-center">
                                                <FaIdCard size={32} className="text-[#EFB036]" />
                                            </div>
                                        )}
                                        {isEditing && (
                                            <>
                                                <input
                                                    type="file"
                                                    accept="image/*"
                                                    onChange={(e) => {
                                                        const file = e.target.files?.[0];
                                                        if (file) {
                                                            const reader = new FileReader();
                                                            reader.onloadend = () => {
                                                                setEditedData(prev => ({
                                                                    ...prev,
                                                                    idBack: reader.result as string
                                                                }));
                                                            };
                                                            reader.readAsDataURL(file);
                                                        }
                                                    }}
                                                    className="hidden"
                                                    id="idBack"
                                                />
                                                <label 
                                                    htmlFor="idBack"
                                                    className="absolute bottom-2 right-2 px-3 py-1 bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] rounded-lg cursor-pointer text-sm"
                                                >
                                                    Change
                                                </label>
                                            </>
                                        )}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </motion.div>
                </div>
            </motion.div>
        </div>
    )
}

export default SettingsPage; 