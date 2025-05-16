"use client";
import { useState, useRef, useEffect } from 'react';
import PersonalInformation from '@/Pages/ClientInformation/Sections/PersonalInformation';
import ContactDetails from '../ClientInformation/Sections/ContactDetails';
import Identification from '@/Pages/ClientInformation/Sections/Identification';
import Documentation from '@/Pages/ClientInformation/Sections/Documentation';
import Review from '@/Pages/ClientInformation/Sections/Review';
import Success from '@/Pages/ClientInformation/Sections/Success';

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
};

type ImagePreview = {
  file: File;
  preview: string;
};

type ImagePreviews = {
  profilePhoto: ImagePreview | null;
  idFront: ImagePreview | null;
  idBack: ImagePreview | null;
  additionalDocs: ImagePreview[];
};

export default function ClientInformationPortal() {
  const [currentSection, setCurrentSection] = useState(0);
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
    };

    // Only access localStorage on the client side
    if (typeof window !== 'undefined') {
      const savedData = localStorage.getItem('clientFormData');
      return savedData ? JSON.parse(savedData) : defaultData;
    }
    return defaultData;
  });
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submissionComplete, setSubmissionComplete] = useState(false);
  const [clientId, setClientId] = useState('');
  const [imagePreviews, setImagePreviews] = useState<ImagePreviews>({
    profilePhoto: null,
    idFront: null,
    idBack: null,
    additionalDocs: [],
  });

  const sections = [
    'Personal Information',
    'Contact Details',
    'Identification',
    'Documentation',
    'Review',
  ];

  const fileInputRefs = {
    profilePhoto: useRef<HTMLInputElement>(null),
    idFront: useRef<HTMLInputElement>(null),
    idBack: useRef<HTMLInputElement>(null),
    additionalDocs: useRef<HTMLInputElement>(null),
  };

  // Save form data to localStorage whenever it changes
  useEffect(() => {
    if (typeof window !== 'undefined') {
      localStorage.setItem('clientFormData', JSON.stringify(formData));
    }
  }, [formData]);

  // Save current section to localStorage
  useEffect(() => {
    if (typeof window !== 'undefined') {
      localStorage.setItem('clientCurrentSection', currentSection.toString());
    }
  }, [currentSection]);

  // Load current section from localStorage on initial render
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const savedSection = localStorage.getItem('clientCurrentSection');
      if (savedSection) {
        setCurrentSection(parseInt(savedSection));
      }
    }
  }, []);

  const handleFileChange = async (field: string, e: React.ChangeEvent<HTMLInputElement> | { target: { files: FileList } }) => {
    const files = 'files' in e.target ? e.target.files : e.target.files;
    if (!files || files.length === 0) return;

    const newFormData = { ...formData };
    const newImagePreviews = { ...imagePreviews };

    if (field === 'additionalDocs') {
        const fileArray = Array.from(files);
        newFormData[field] = fileArray;
        
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
        newImagePreviews[field] = fileArray.map((file, index) => ({
            file,
            preview: base64Array[index]
        }));
    } else {
        const file = files[0];
        newFormData[field as keyof FormData] = file;

        // Convert file to base64
        const base64 = await new Promise<string>((resolve) => {
            const reader = new FileReader();
            reader.onloadend = () => {
                resolve(reader.result as string);
            };
            reader.readAsDataURL(file);
        });

        newImagePreviews[field as keyof ImagePreviews] = {
            file,
            preview: base64
        };
    }

    setFormData(newFormData);
    setImagePreviews(newImagePreviews);
  };

  const removeImage = (field: string, index: number | null = null) => {
    const newFormData = { ...formData };
    const newImagePreviews = { ...imagePreviews };

    if (field === 'additionalDocs' && index !== null) {
      newFormData[field]!.splice(index, 1);
      newImagePreviews[field].splice(index, 1);
    } else {
      newFormData[field as keyof FormData] = null;
      newImagePreviews[field as keyof ImagePreviews] = null;
    }

    setFormData(newFormData);
    setImagePreviews(newImagePreviews);
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value, type, checked } = e.target;
    setFormData({
      ...formData,
      [name]: type === 'checkbox' ? checked : value,
    });
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
        else if (!/^\d+$/.test(formData.phone.replace(/[\s-+]/g, '')))
          newErrors.phone = 'Phone number should only contain numbers';

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
        else if (!/^\d+(-\d+)?$/.test(formData.zipCode))
          newErrors.zipCode = 'ZIP code should only contain numbers';

        if (!formData.country) newErrors.country = 'Country is required';
        else if (!/^[a-zA-Z\s]*$/.test(formData.country)) 
          newErrors.country = 'Country should only contain letters';

        if (formData.alternateContact) {
          if (!/^\+?[\d\s-]{10,}$/.test(formData.alternateContact))
            newErrors.alternateContact = 'Please enter a valid phone number';
          else if (!/^\d+$/.test(formData.alternateContact.replace(/[\s-+]/g, '')))
            newErrors.alternateContact = 'Phone number should only contain numbers';
        }
        break;

      case 2: // Identification
        if (!formData.idType) newErrors.idType = 'ID type is required';
        
        if (!formData.idNumber) newErrors.idNumber = 'ID number is required';
        else if (!/^[A-Za-z0-9-]+$/.test(formData.idNumber))
          newErrors.idNumber = 'ID number should only contain letters, numbers, and hyphens';
        else if (!/^\d+$/.test(formData.idNumber.replace(/[A-Za-z-]/g, '')))
          newErrors.idNumber = 'ID number must contain at least one number';

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
      setCurrentSection(Math.min(currentSection + 1, sections.length - 1));
    }
  };

  const prevSection = () => {
    setCurrentSection(Math.max(currentSection - 1, 0));
  };

  const submitForm = () => {
    if (validateSection()) {
        setTimeout(async () => {
            const randomNum = Math.floor(1000 + Math.random() * 9000);
            const newClientId = `CL-${new Date().getFullYear()}-${randomNum}`;
            setClientId(newClientId);
            
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
                localStorage.setItem(`clientFormData_${newClientId}`, JSON.stringify(formDataToStore));
            }
            
            setSubmissionComplete(true);
        }, 2000);
    }
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
    });
    setImagePreviews({
      profilePhoto: null,
      idFront: null,
      idBack: null,
      additionalDocs: [],
    });
    setErrors({});
    setCurrentSection(0);
    setSubmissionComplete(false);
    // Clear current form data from localStorage
    if (typeof window !== 'undefined') {
      localStorage.removeItem('clientFormData');
      localStorage.removeItem('clientCurrentSection');
    }
  };

  useEffect(() => {
    return () => {
      Object.values(imagePreviews).forEach(preview => {
        if (Array.isArray(preview)) {
          preview.forEach(item => {
            if (item?.preview) URL.revokeObjectURL(item.preview);
          });
        } else if (preview?.preview) {
          URL.revokeObjectURL(preview.preview);
        }
      });
    };
  }, [imagePreviews]);

  return (
    <div className="min-h-screen bg-[#FEF3E2] text-[#23486A]">
      <header className="bg-[#23486A] text-white py-5 text-center relative overflow-hidden">
        <div className="header-content relative z-10">
          <h1 className="text-3xl md:text-4xl  mb-2 font-semibold  text-[#EFB036]">Client Information Portal</h1>
          <p className="text-lg text-[#23486A]">Please complete all sections to register your information</p>
        </div>
        <div className="header-wave absolute bottom-0 left-0 w-full h-12 bg-[#FEF3E2]"></div>
      </header>

      <div className="container mx-auto px-4 py-8 max-w-6xl">
        {!submissionComplete && (
          <div className="progress-tracker flex justify-between relative my-8">
            <div className="absolute top-1/2 left-0 w-full h-1 bg-[#4C7B8B] -translate-y-1/2 z-10"></div>
            {sections.map((_, index) => (
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
                  {sections[index].split(' ')[0]}
                </span>
              </div>
            ))}
          </div>
        )}

        {!submissionComplete ? (
          <div className="bg-white rounded-xl shadow-lg p-6 mb-8">
            {currentSection === 0 && (
              <PersonalInformation 
                formData={formData}
                errors={errors}
                handleChange={handleChange}
                nextSection={nextSection}
              />
            )}
            {currentSection === 1 && (
              <ContactDetails 
                formData={formData}
                errors={errors}
                handleChange={handleChange}
                prevSection={prevSection}
                nextSection={nextSection}
              />
            )}
            {currentSection === 2 && (
              <Identification 
                formData={formData}
                errors={errors}
                handleChange={handleChange}
                prevSection={prevSection}
                nextSection={nextSection}
              />
            )}
            {currentSection === 3 && (
              <Documentation 
                formData={formData}
                errors={errors}
                imagePreviews={imagePreviews}
                fileInputRefs={fileInputRefs}
                handleFileChange={handleFileChange}
                removeImage={removeImage}
                prevSection={prevSection}
                nextSection={nextSection}
              />
            )}
            {currentSection === 4 && (
              <Review 
                formData={formData}
                errors={errors}
                imagePreviews={imagePreviews}
                handleChange={handleChange}
                prevSection={prevSection}
                submitForm={submitForm}
              />
            )}
          </div>
        ) : (
          <Success 
            clientId={clientId}
            resetForm={resetForm}
          />
        )}
      </div>
    </div>
  );
}