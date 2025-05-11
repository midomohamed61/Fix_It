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
  const [formData, setFormData] = useState<FormData>({
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

  const handleFileChange = (field: string, e: React.ChangeEvent<HTMLInputElement> | { target: { files: FileList } }) => {
    const files = 'files' in e.target ? e.target.files : e.target.files;
    if (!files || files.length === 0) return;

    const newFormData = { ...formData };
    const newImagePreviews = { ...imagePreviews };

    if (field === 'additionalDocs') {
      newFormData[field] = Array.from(files);
      newImagePreviews[field] = Array.from(files).map(file => ({
        file,
        preview: URL.createObjectURL(file),
      }));
    } else {
      newFormData[field as keyof FormData] = files[0] as File;
      newImagePreviews[field as keyof ImagePreviews] = {
        file: files[0],
        preview: URL.createObjectURL(files[0]),
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

  const validateSection = (sectionIndex: number) => {
    const newErrors: Record<string, string> = {};
    let isValid = true;

    if (sectionIndex === 0) {
      if (!formData.firstName.trim()) {
        newErrors.firstName = 'Please enter your first name';
        isValid = false;
      }
      if (!formData.lastName.trim()) {
        newErrors.lastName = 'Please enter your last name';
        isValid = false;
      }
      if (!formData.dob) {
        newErrors.dob = 'Please enter your date of birth';
        isValid = false;
      }
    } else if (sectionIndex === 1) {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!formData.email.trim()) {
        newErrors.email = 'Please enter your email address';
        isValid = false;
      } else if (!emailRegex.test(formData.email)) {
        newErrors.email = 'Please enter a valid email address';
        isValid = false;
      }

      const phoneRegex = /^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$/;
      if (!formData.phone.trim()) {
        newErrors.phone = 'Please enter your phone number';
        isValid = false;
      } else if (!phoneRegex.test(formData.phone)) {
        newErrors.phone = 'Please enter a valid phone number';
        isValid = false;
      }

      if (!formData.address.trim()) {
        newErrors.address = 'Please enter your address';
        isValid = false;
      }
      if (!formData.city.trim()) {
        newErrors.city = 'Please enter your city';
        isValid = false;
      }
      if (!formData.zipCode.trim()) {
        newErrors.zipCode = 'Please enter your postal/zip code';
        isValid = false;
      }
      if (!formData.country.trim()) {
        newErrors.country = 'Please enter your country';
        isValid = false;
      }
    } else if (sectionIndex === 2) {
      if (!formData.idType) {
        newErrors.idType = 'Please select an ID type';
        isValid = false;
      }
      if (!formData.idNumber.trim()) {
        newErrors.idNumber = 'Please enter your ID number';
        isValid = false;
      }
      if (!formData.expiryDate) {
        newErrors.expiryDate = 'Please enter an expiry date';
        isValid = false;
      } else if (new Date(formData.expiryDate) <= new Date()) {
        newErrors.expiryDate = 'Expiry date must be in the future';
        isValid = false;
      }
      if (!formData.issuingAuthority.trim()) {
        newErrors.issuingAuthority = 'Please enter the issuing authority';
        isValid = false;
      }
      if (!formData.issuingCountry.trim()) {
        newErrors.issuingCountry = 'Please enter the issuing country';
        isValid = false;
      }
    } else if (sectionIndex === 3) {
      if (!formData.profilePhoto) {
        newErrors.profilePhoto = 'Please upload a profile photo';
        isValid = false;
      }
      if (!formData.idFront) {
        newErrors.idFront = 'Please upload the front of your ID';
        isValid = false;
      }
    } else if (sectionIndex === 4) {
      if (!formData.confirmation) {
        newErrors.confirmation = 'Please confirm that your information is accurate';
        isValid = false;
      }
    }

    setErrors(newErrors);
    return isValid;
  };

  const nextSection = () => {
    if (validateSection(currentSection)) {
      setCurrentSection(Math.min(currentSection + 1, sections.length - 1));
    }
  };

  const prevSection = () => {
    setCurrentSection(Math.max(currentSection - 1, 0));
  };

  const submitForm = () => {
    if (validateSection(4)) {
      setTimeout(() => {
        const randomNum = Math.floor(1000 + Math.random() * 9000);
        setClientId(`CL-${new Date().getFullYear()}-${randomNum}`);
        setSubmissionComplete(true);
      }, 2000);
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