"use client";
import { useState, useRef, useEffect } from 'react';
import { motion } from 'framer-motion';
import PersonalInformation from '@/Pages/WorkerInformation/Sections/PersonalInformation';
import ContactDetails from '../WorkerInformation/Sections/ContactDetails';
import Identification from '@/Pages/WorkerInformation/Sections/Identification';
import Documentation from '@/Pages/WorkerInformation/Sections/Documentation';
import Review from '@/Pages/WorkerInformation/Sections/Review';
import Success from '@/Pages/WorkerInformation/Sections/Success';
import StoredData from './Sections/StoredData';
import { Button } from "@/components/ui/Button/Button";

type FormData = {
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
    alternateContact: string;
    idType: string;
    idNumber: string;
    issueDate: string;
    expiryDate: string;
    issuingAuthority: string;
    issuingCountry: string;
    profilePhoto: File | null;
    idFront: File | null;
    idBack: File | null;
    additionalDocs: File[] | null;
    confirmation: boolean;
    termsAccepted: boolean;
};

type ImagePreviews = {
    profilePhoto: { preview: string; file: File } | null;
    idFront: { preview: string; file: File } | null;
    idBack: { preview: string; file: File } | null;
    additionalDocs: Array<{ preview: string; file: File }>;
};

export default function WorkerInformation() {
    const [currentSection, setCurrentSection] = useState(0);
    const [submissionComplete, setSubmissionComplete] = useState(false);
    const [workerId, setWorkerId] = useState('');
    const [formData, setFormData] = useState<FormData>(() => {
        // Initialize with default values
        const defaultData = {
            firstName: '',
            lastName: '',
            dob: '',
            gender: '',
            nationality: '',
            occupation: '',
            email: '',
            phone: '',
            address: '',
            city: '',
            state: '',
            zipCode: '',
            country: '',
            alternateContact: '',
            idType: '',
            idNumber: '',
            issueDate: '',
            expiryDate: '',
            issuingAuthority: '',
            issuingCountry: '',
            profilePhoto: null,
            idFront: null,
            idBack: null,
            additionalDocs: null,
            confirmation: false,
            termsAccepted: false,
        };

        // Only access localStorage on the client side
        if (typeof window !== 'undefined') {
            const savedData = localStorage.getItem('workerFormData');
            return savedData ? JSON.parse(savedData) : defaultData;
        }
        return defaultData;
    });

    const [errors, setErrors] = useState<Record<string, string>>({});
    const [imagePreviews, setImagePreviews] = useState<ImagePreviews>({
        profilePhoto: null,
        idFront: null,
        idBack: null,
        additionalDocs: []
    });

    const [showStoredData, setShowStoredData] = useState(false);

    const fileInputRefs = {
        profilePhoto: useRef<HTMLInputElement>(null!),
        idFront: useRef<HTMLInputElement>(null!),
        idBack: useRef<HTMLInputElement>(null!),
        additionalDocs: useRef<HTMLInputElement>(null!)
    };

    // Save form data to localStorage whenever it changes
    useEffect(() => {
        if (typeof window !== 'undefined') {
            localStorage.setItem('workerFormData', JSON.stringify(formData));
        }
    }, [formData]);

    // Save current section to localStorage
    useEffect(() => {
        if (typeof window !== 'undefined') {
            localStorage.setItem('workerCurrentSection', currentSection.toString());
        }
    }, [currentSection]);

    // Load current section from localStorage on initial render
    useEffect(() => {
        if (typeof window !== 'undefined') {
            const savedSection = localStorage.getItem('workerCurrentSection');
            if (savedSection) {
                setCurrentSection(parseInt(savedSection));
            }
        }
    }, []);

    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { name, value, type } = e.target;
        setFormData(prev => ({
            ...prev,
            [name]: type === 'checkbox' ? (e.target as HTMLInputElement).checked : value
        }));
        // Clear error when field is modified
        if (errors[name]) {
            setErrors(prev => {
                const newErrors = { ...prev };
                delete newErrors[name];
                return newErrors;
            });
        }
    };

    const handleFileChange = async (field: string, e: React.ChangeEvent<HTMLInputElement> | { target: { files: FileList | null } }) => {
        const files = e.target.files;
        if (!files || files.length === 0) return;

        const newFormData = { ...formData };
        const newImagePreviews = { ...imagePreviews };

        if (field === 'additionalDocs') {
            const fileArray = Array.from(files) as File[];
            newFormData.additionalDocs = fileArray;
            
            // Convert files to base64
            const base64Promises = fileArray.map(file => {
                return new Promise<string>((resolve) => {
                    const reader = new FileReader();
                    reader.onloadend = () => {
                        resolve(reader.result as string);
                    };
                    reader.readAsDataURL(file);
                });
            });

            const base64Array = await Promise.all(base64Promises);
            newImagePreviews.additionalDocs = fileArray.map((file, index) => ({
                file,
                preview: base64Array[index]
            }));
        } else {
            const file = files[0];
            if (field === 'profilePhoto' || field === 'idFront' || field === 'idBack') {
                newFormData[field] = file;

                // Convert file to base64
                const base64 = await new Promise<string>((resolve) => {
                    const reader = new FileReader();
                    reader.onloadend = () => {
                        resolve(reader.result as string);
                    };
                    reader.readAsDataURL(file);
                });

                newImagePreviews[field] = {
                    file,
                    preview: base64
                };
            }
        }

        setFormData(newFormData);
        setImagePreviews(newImagePreviews);
    };

    // Helper function to convert File to base64
    const fileToBase64 = (file: File): Promise<string> => {
        return new Promise((resolve) => {
            const reader = new FileReader();
            reader.onloadend = () => {
                resolve(reader.result as string);
            };
            reader.readAsDataURL(file);
        });
    };

    const removeImage = (field: string, index?: number) => {
        if (field === 'additionalDocs' && typeof index === 'number') {
            setImagePreviews(prev => ({
                ...prev,
                additionalDocs: prev.additionalDocs.filter((_, i) => i !== index)
            }));
            setFormData(prev => ({
                ...prev,
                additionalDocs: prev.additionalDocs?.filter((_, i) => i !== index) || null
            }));
        } else {
            setImagePreviews(prev => ({
                ...prev,
                [field]: null
            }));
            setFormData(prev => ({
                ...prev,
                [field]: null
            }));
        }
    };

    const validateSection = () => {
        const newErrors: Record<string, string> = {};

        switch (currentSection) {
            case 0: // Personal Information
                if (!formData.firstName) newErrors.firstName = 'First name is required';
                else if (formData.firstName.length < 2) newErrors.firstName = 'First name must be at least 2 characters';
                else if (!/^[a-zA-Z\s]*$/.test(formData.firstName)) newErrors.firstName = 'First name should only contain letters';

                if (!formData.lastName) newErrors.lastName = 'Last name is required';
                else if (formData.lastName.length < 2) newErrors.lastName = 'Last name must be at least 2 characters';
                else if (!/^[a-zA-Z\s]*$/.test(formData.lastName)) newErrors.lastName = 'Last name should only contain letters';

                if (!formData.dob) newErrors.dob = 'Date of birth is required';
                else {
                    const dob = new Date(formData.dob);
                    const today = new Date();
                    const age = today.getFullYear() - dob.getFullYear();
                    if (age < 18) newErrors.dob = 'Must be at least 18 years old';
                    if (age > 100) newErrors.dob = 'Please enter a valid date of birth';
                }

                if (!formData.gender) newErrors.gender = 'Gender is required';
                if (!formData.nationality) newErrors.nationality = 'Nationality is required';
                if (!formData.occupation) newErrors.occupation = 'Occupation is required';
                break;

            case 1: // Contact Details
                if (!formData.email) newErrors.email = 'Email is required';
                else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email)) 
                    newErrors.email = 'Please enter a valid email address';

                if (!formData.phone) newErrors.phone = 'Phone number is required';
                else if (!/^\+?[\d\s-]{10,}$/.test(formData.phone)) 
                    newErrors.phone = 'Please enter a valid phone number';

                if (!formData.address) newErrors.address = 'Address is required';
                else if (formData.address.length < 5) 
                    newErrors.address = 'Address must be at least 5 characters';

                if (!formData.city) newErrors.city = 'City is required';
                else if (!/^[a-zA-Z\s]*$/.test(formData.city)) 
                    newErrors.city = 'City should only contain letters';

                if (!formData.state) newErrors.state = 'State is required';
                else if (!/^[a-zA-Z\s]*$/.test(formData.state)) 
                    newErrors.state = 'State should only contain letters';

                if (!formData.zipCode) newErrors.zipCode = 'ZIP code is required';
                else if (!/^\d{5}(-\d{4})?$/.test(formData.zipCode)) 
                    newErrors.zipCode = 'Please enter a valid ZIP code';

                if (!formData.country) newErrors.country = 'Country is required';
                else if (!/^[a-zA-Z\s]*$/.test(formData.country)) 
                    newErrors.country = 'Country should only contain letters';

                break;

            case 2: // Identification
                if (!formData.idType) newErrors.idType = 'ID type is required';
                
                if (!formData.idNumber) newErrors.idNumber = 'ID number is required';
                else if (!/^\d{14}$/.test(formData.idNumber))
                    newErrors.idNumber = 'ID number must be exactly 14 numbers';

                if (!formData.issueDate) newErrors.issueDate = 'Issue date is required';
                else {
                    const issueDate = new Date(formData.issueDate);
                    const today = new Date();
                    if (issueDate > today) newErrors.issueDate = 'Issue date cannot be in the future';
                }

                if (!formData.expiryDate) newErrors.expiryDate = 'Expiry date is required';
                else {
                    const expiryDate = new Date(formData.expiryDate);
                    const today = new Date();
                    if (expiryDate <= today) newErrors.expiryDate = 'Expiry date must be in the future';
                }

                if (!formData.issuingAuthority) newErrors.issuingAuthority = 'Issuing authority is required';
                else if (!/^[a-zA-Z\s]*$/.test(formData.issuingAuthority))
                    newErrors.issuingAuthority = 'Issuing authority should only contain letters';

                if (!formData.issuingCountry) newErrors.issuingCountry = 'Issuing country is required';
                else if (!/^[a-zA-Z\s]*$/.test(formData.issuingCountry))
                    newErrors.issuingCountry = 'Issuing country should only contain letters';
                break;

            case 3: // Documentation
                if (!formData.profilePhoto) newErrors.profilePhoto = 'Profile photo is required';
                if (!formData.idFront) newErrors.idFront = 'ID front image is required';
                break;

            case 4: // Review
                if (!formData.confirmation) newErrors.confirmation = 'Please confirm the information is accurate';
                break;
        }

        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    const nextSection = () => {
        if (validateSection()) {
            setCurrentSection(prev => prev + 1);
        }
    };

    const prevSection = () => {
        setCurrentSection(prev => prev - 1);
    };

    const submitForm = async () => {
        try {
            // Generate a unique worker ID (WR-YYYY-RRRR format)
            const year = new Date().getFullYear();
            const random = Math.floor(1000 + Math.random() * 9000);
            const newWorkerId = `WR-${year}-${random}`;

            // Convert File objects to base64 before storing
            const formDataToStore = {
                ...formData,
                profilePhoto: formData.profilePhoto ? await fileToBase64(formData.profilePhoto) : null,
                idFront: formData.idFront ? await fileToBase64(formData.idFront) : null,
                idBack: formData.idBack ? await fileToBase64(formData.idBack) : null,
                additionalDocs: formData.additionalDocs ? await Promise.all(
                    formData.additionalDocs.map(file => fileToBase64(file))
                ) : null
            };

            // Save form data with unique ID
            if (typeof window !== 'undefined') {
                localStorage.setItem(`workerFormData_${newWorkerId}`, JSON.stringify(formDataToStore));
            }

            // Clear the form
            resetForm();
            
            // Show success message
            alert('Worker information submitted successfully!');
        } catch (error) {
            console.error('Error submitting form:', error);
            alert('Error submitting form. Please try again.');
        }
    };

    const resetForm = () => {
        setFormData({
            firstName: '',
            lastName: '',
            dob: '',
            gender: '',
            nationality: '',
            occupation: '',
            email: '',
            phone: '',
            address: '',
            city: '',
            state: '',
            zipCode: '',
            country: '',
            alternateContact: '',
            idType: '',
            idNumber: '',
            issueDate: '',
            expiryDate: '',
            issuingAuthority: '',
            issuingCountry: '',
            profilePhoto: null,
            idFront: null,
            idBack: null,
            additionalDocs: null,
            confirmation: false,
            termsAccepted: false
        });
        setCurrentSection(0); // Reset to first section
        setErrors({});
        if (typeof window !== 'undefined') {
            localStorage.removeItem('workerFormData');
            localStorage.removeItem('workerCurrentSection');
        }
    };

    // Cleanup preview URLs when component unmounts
    useEffect(() => {
        return () => {
            Object.values(imagePreviews).forEach(preview => {
                if (preview && 'preview' in preview) {
                    URL.revokeObjectURL(preview.preview);
                }
            });
            imagePreviews.additionalDocs.forEach(doc => {
                URL.revokeObjectURL(doc.preview);
            });
        };
    }, []);

    const sections = [
        <PersonalInformation
            key="personal"
            formData={formData}
            errors={errors}
            handleChange={handleChange}
            nextSection={nextSection}
        />,
        <ContactDetails
            key="contact"
            formData={formData}
            errors={errors}
            handleChange={handleChange}
            prevSection={prevSection}
            nextSection={nextSection}
        />,
        <Identification
            key="identification"
            formData={formData}
            errors={errors}
            handleChange={handleChange}
            prevSection={prevSection}
            nextSection={nextSection}
        />,
        <Documentation
            key="documentation"
            formData={formData}
            errors={errors}
            imagePreviews={imagePreviews}
            fileInputRefs={fileInputRefs}
            handleFileChange={handleFileChange}
            removeImage={removeImage}
            prevSection={prevSection}
            nextSection={nextSection}
        />,
        <Review
            key="review"
            formData={formData}
            errors={errors}
            imagePreviews={imagePreviews}
            handleChange={handleChange}
            prevSection={prevSection}
            submitForm={submitForm}
        />,
        <Success
            key="success"
            workerId={workerId}
            resetForm={resetForm}
        />
    ];

    const sectionNames = [
        'Personal Information',
        'Contact Details',
        'Identification',
        'Documentation',
        'Review',
    ];

    if (showStoredData) {
        return <StoredData />;
    }

    return (
        <div className="min-h-screen bg-gradient-to-br from-[#FEF3E2] to-[#F5F5F5]">
            <header className="bg-[#23486A] text-white py-5 text-center relative overflow-hidden">
                <div className="header-content relative z-10">
                    <h1 className="text-3xl md:text-4xl mb-2 font-semibold text-[#EFB036]">Worker Information Portal</h1>
                    <p className="text-lg text-[#23486A]">Please complete all sections to register your information</p>
                </div>
                <div className="header-wave absolute bottom-0 left-0 w-full h-12 bg-[#FEF3E2]"></div>
            </header>
            <div className="py-12 px-4 sm:px-6 lg:px-8">
                <div className="max-w-4xl mx-auto">
                    {!submissionComplete && (
                        <div className="progress-tracker flex justify-between relative my-8">
                            <div className="absolute top-1/2 left-0 w-full h-1 bg-[#4C7B8B] -translate-y-1/2 z-10"></div>
                            {sectionNames.map((name, index) => (
                                <div
                                    key={index}
                                    className={`progress-step w-10 h-10 rounded-full flex items-center justify-center font-bold relative z-20 transition-all ${
                                        index === currentSection
                                            ? 'bg-[#EFB036] scale-110'
                                            : index < currentSection
                                            ? 'bg-[#23486A]'
                                            : 'bg-[#4C7B8B]'
                                    }`}
                                >
                                    <span className={`text-lg font-bold ${
                                        index === currentSection
                                            ? 'text-white'
                                            : index < currentSection
                                            ? 'text-[#EFB036]'
                                            : 'text-white'
                                    }`}>
                                        {index + 1}
                                    </span>
                                    <span className="progress-label absolute -bottom-6 left-1/2 -translate-x-1/2 text-sm whitespace-nowrap text-[#4C7B8B]">
                                        {name.split(' ')[0]}
                                    </span>
                                </div>
                            ))}
                        </div>
                    )}
                    <div className="flex justify-between items-center mb-8">
                        <h1 className="text-3xl font-semibold text-[#23486A]">Worker Information</h1>
                        <Button
                            onClick={() => setShowStoredData(true)}
                            className="bg-[#EFB036] hover:bg-[#e5a82e] text-white px-4 py-2 rounded-lg"
                        >
                            View Stored Data
                        </Button>
                    </div>
                    <div className="bg-white rounded-2xl shadow-xl p-8">
                        {sections[currentSection]}
                    </div>
                </div>
            </div>
        </div>
    );
} 