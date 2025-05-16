import { Button } from "@/components/ui/Button/Button";
import { Input } from "@/components/ui/Form/Input";
import { Label } from "@/components/ui/Form/Label";

export default function Documentation({
    // formData,
    errors,
    imagePreviews,
    fileInputRefs,
    handleFileChange,
    removeImage,
    prevSection,
    nextSection
}: {
    formData: {
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
      profilePhoto: File | null;
      idFront: File | null;
      idBack: File | null;
      additionalDocs: File[] | null;
      confirmation: boolean;
    };
    errors: Record<string, string>;
    imagePreviews: {
        profilePhoto: { preview: string; file: File } | null;
        idFront: { preview: string; file: File } | null;
        idBack: { preview: string; file: File } | null;
        additionalDocs: Array<{ preview: string; file: File }>;
    };
    fileInputRefs: {
        profilePhoto: React.RefObject<HTMLInputElement>;
        idFront: React.RefObject<HTMLInputElement>;
        idBack: React.RefObject<HTMLInputElement>;
        additionalDocs: React.RefObject<HTMLInputElement>;
    };
    handleFileChange: (field: string, e: React.ChangeEvent<HTMLInputElement> | { target: { files: FileList } }) => void;
    removeImage: (field: string, index?: number) => void;
    prevSection: () => void;
    nextSection: () => void;
}) {
    return (
      <div className="form-section">
        <h2 className="text-2xl font-semibold text-[#3B6790] mb-5 pb-2 border-b-2 border-[#EFB036]">
          Documentation
        </h2>
        
        <div className="flex flex-wrap -mx-4 mb-5">
          <div className="w-full px-4 mb-5">
            <Label className="block font-medium mb-2 text-[#3B6790]">Profile Photo*</Label>
            <div
              className={`file-upload w-full h-48 border-2 border-dashed rounded-xl text-center transition-all relative overflow-hidden ${
                errors.profilePhoto ? 'border-red-500' : 'border-[#4C7B8B] hover:border-[#EFB036]'
              }`}
              onClick={() => fileInputRefs.profilePhoto.current!.click()}
              onDragOver={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#EFB036';
                e.currentTarget.style.backgroundColor = 'rgba(239, 176, 54, 0.1)';
              }}
              onDragLeave={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#4C7B8B';
                e.currentTarget.style.backgroundColor = 'rgba(76, 123, 139, 0.05)';
              }}
              onDrop={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#4C7B8B';
                e.currentTarget.style.backgroundColor = 'rgba(76, 123, 139, 0.05)';
                if (e.dataTransfer.files.length) {
                  handleFileChange('profilePhoto', {
                    target: { files: e.dataTransfer.files },
                  });
                }
              }}
            >
              <Input
                type="file"
                ref={fileInputRefs.profilePhoto}
                accept="image/*"
                id="profilePhoto"
                name="profilePhoto"
                onChange={(e) => handleFileChange('profilePhoto', e)}
                className="hidden "
              />
              <div className="file-upload-content flex flex-col items-center justify-center h-full text-[#3B6790]">
                <div className="file-upload-icon text-5xl mb-2">📷</div>
                <p>Click or drag to upload your profile photo</p>
                <p className="text-sm text-[#4C7B8B]">Max size: 5MB, Formats: JPG, PNG</p>
              </div>
            </div>
            {errors.profilePhoto && (
              <p className="text-red-500 text-sm mt-1">{errors.profilePhoto}</p>
            )}
            {imagePreviews.profilePhoto && (
              <div className="image-preview-container flex flex-wrap gap-4 mt-5">
                <div className="image-preview w-28 h-28 rounded-lg overflow-hidden relative shadow-md border-2 border-[#4C7B8B]">
                  <img
                    src={imagePreviews.profilePhoto.preview}
                    alt="Profile Preview"
                    className="w-full h-full object-cover"
                  />
                  <div
                    className="remove-image absolute top-1 right-1 w-6 h-6 bg-white bg-opacity-70 rounded-full flex items-center justify-center cursor-pointer transition-all hover:bg-white hover:scale-110 text-[#23486A]"
                    onClick={() => removeImage('profilePhoto')}
                  >
                    ×
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
  
        <div className="flex flex-wrap -mx-4 mb-5">
          <div className="w-full px-4 mb-5">
            <Label style={{ color: '#23486A' }}>ID Document (Front)*</Label>
            <div
              className={`file-upload w-full h-48 border-2 border-dashed rounded-xl text-center transition-all relative overflow-hidden ${
                errors.idFront ? 'border-red-500' : 'border-[#4C7B8B] hover:border-[#EFB036]'
              }`}
              onClick={() => fileInputRefs.idFront.current!.click()}
              onDragOver={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#EFB036';
                e.currentTarget.style.backgroundColor = 'rgba(239, 176, 54, 0.1)';
              }}
              onDragLeave={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#4C7B8B';
                e.currentTarget.style.backgroundColor = 'rgba(76, 123, 139, 0.05)';
              }}
              onDrop={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#4C7B8B';
                e.currentTarget.style.backgroundColor = 'rgba(76, 123, 139, 0.05)';
                if (e.dataTransfer.files.length) {
                  handleFileChange('idFront', {
                    target: { files: e.dataTransfer.files },
                  });
                }
              }}
            >
              <Input
                type="file"
                ref={fileInputRefs.idFront}
                accept="image/*"
                id="idFront"
                name="idFront"
                onChange={(e) => handleFileChange('idFront', e)}
                className="hidden"
                required
              />
              <div className="file-upload-content flex flex-col items-center justify-center h-full text-[#3B6790]">
                <div className="file-upload-icon text-5xl mb-2">🪪</div>
                <p>Click or drag to upload front of your ID</p>
                <p className="text-sm text-[#4C7B8B]">Max size: 5MB, Formats: JPG, PNG</p>
              </div>
            </div>
            {errors.idFront && (
              <p className="text-red-500 text-sm mt-1">{errors.idFront}</p>
            )}
            {imagePreviews.idFront && (
              <div className="image-preview-container flex flex-wrap gap-4 mt-5">
                <div className="image-preview w-28 h-28 rounded-lg overflow-hidden relative shadow-md border-2 border-[#4C7B8B]">
                  <img
                    src={imagePreviews.idFront.preview}
                    alt="ID Front Preview"
                    className="w-full h-full object-cover"
                  />
                  <div
                    className="remove-image absolute top-1 right-1 w-6 h-6 bg-white bg-opacity-70 rounded-full flex items-center justify-center cursor-pointer transition-all hover:bg-white hover:scale-110 text-[#23486A]"
                    onClick={() => removeImage('idFront')}
                  >
                    ×
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
  
        <div className="flex flex-wrap -mx-4 mb-5">
          <div className="w-full px-4 mb-5">
            <Label style={{ color: '#23486A' }}>ID Document (Back)</Label>
            <div
              className="file-upload w-full h-48 border-2 border-dashed border-[#4C7B8B] rounded-xl text-center transition-all relative overflow-hidden hover:border-[#EFB036]"
              onClick={() => fileInputRefs.idBack.current!.click()}
              onDragOver={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#EFB036';
                e.currentTarget.style.backgroundColor = 'rgba(239, 176, 54, 0.1)';
              }}
              onDragLeave={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#4C7B8B';
                e.currentTarget.style.backgroundColor = 'rgba(76, 123, 139, 0.05)';
              }}
              onDrop={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#4C7B8B';
                e.currentTarget.style.backgroundColor = 'rgba(76, 123, 139, 0.05)';
                if (e.dataTransfer.files.length) {
                  handleFileChange('idBack', {
                    target: { files: e.dataTransfer.files },
                  });
                }
              }}
            >
              <Input
                type="file"
                ref={fileInputRefs.idBack}
                accept="image/*"
                id="idBack"
                name="idBack"
                onChange={(e) => handleFileChange('idBack', e)}
                className="hidden"
              />
              <div className="file-upload-content flex flex-col items-center justify-center h-full text-[#3B6790]">
                <div className="file-upload-icon text-5xl mb-2">🪪</div>
                <p>Click or drag to upload back of your ID</p>
                <p className="text-sm text-[#4C7B8B]">Max size: 5MB, Formats: JPG, PNG</p>
              </div>
            </div>
            {imagePreviews.idBack && (
              <div className="image-preview-container flex flex-wrap gap-4 mt-5">
                <div className="image-preview w-28 h-28 rounded-lg overflow-hidden relative shadow-md border-2 border-[#4C7B8B]">
                  <img
                    src={imagePreviews.idBack.preview}
                    alt="ID Back Preview"
                    className="w-full h-full object-cover"
                  />
                  <div
                    className="remove-image absolute top-1 right-1 w-6 h-6 bg-white bg-opacity-70 rounded-full flex items-center justify-center cursor-pointer transition-all hover:bg-white hover:scale-110 text-[#23486A]"
                    onClick={() => removeImage('idBack')}
                  >
                    ×
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
  
        <div className="flex flex-wrap -mx-4 mb-5">
          <div className="w-full px-4 mb-5">
            <Label style={{ color: '#23486A' }}>Additional Documents (Optional)</Label>
            <div
              className="file-upload w-full h-48 border-2 border-dashed border-[#4C7B8B] rounded-xl text-center transition-all relative overflow-hidden hover:border-[#EFB036]"
              onClick={() => fileInputRefs.additionalDocs.current!.click()}
              onDragOver={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#EFB036';
                e.currentTarget.style.backgroundColor = 'rgba(239, 176, 54, 0.1)';
              }}
              onDragLeave={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#4C7B8B';
                e.currentTarget.style.backgroundColor = 'rgba(76, 123, 139, 0.05)';
              }}
              onDrop={(e) => {
                e.preventDefault();
                e.currentTarget.style.borderColor = '#4C7B8B';
                e.currentTarget.style.backgroundColor = 'rgba(76, 123, 139, 0.05)';
                if (e.dataTransfer.files.length) {
                  handleFileChange('additionalDocs', {
                    target: { files: e.dataTransfer.files },
                  });
                }
              }}
            >
              <Input
                type="file"
                ref={fileInputRefs.additionalDocs}
                accept="image/*,.pdf"
                id="additionalDocs"
                name="additionalDocs"
                onChange={(e) => handleFileChange('additionalDocs', e)}
                className="hidden"
                multiple
              />
              <div className="file-upload-content flex flex-col items-center justify-center h-full text-[#3B6790]">
                <div className="file-upload-icon text-5xl mb-2">📄</div>
                <p>Click or drag to upload additional documents</p>
                <p className="text-sm text-[#4C7B8B]">Max size: 10MB, Formats: JPG, PNG, PDF</p>
              </div>
            </div>
            {imagePreviews.additionalDocs.length > 0 && (
              <div className="image-preview-container flex flex-wrap gap-4 mt-5">
                {imagePreviews.additionalDocs.map((doc, index) => (
                  <div key={index} className="image-preview w-28 h-28 rounded-lg overflow-hidden relative shadow-md border-2 border-[#4C7B8B]">
                    {doc.file.type.startsWith('image/') ? (
                      <img
                        src={doc.preview}
                        alt={`Document ${index + 1}`}
                        className="w-full h-full object-cover"
                      />
                    ) : (
                      <div className="w-full h-full bg-[#FEF3E2] flex items-center justify-center">
                        <span className="text-3xl">📄</span>
                      </div>
                    )}
                    <div
                      className="remove-image absolute top-1 right-1 w-6 h-6 bg-white bg-opacity-70 rounded-full flex items-center justify-center cursor-pointer transition-all hover:bg-white hover:scale-110 text-[#23486A]"
                      onClick={() => removeImage('additionalDocs', index)}
                    >
                      ×
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
  
        <div className="flex justify-between mt-8">
          <Button
            type="button"
            onClick={prevSection}
            className="bg-transparent border-2 border-[#23486A] text-[#23486A] hover:bg-[#4C7B8B] hover:text-white font-medium py-3 px-6 rounded-lg transition-all hover:-translate-y-0.5 shadow-md hover:shadow-lg"
          >
            Previous
          </Button>
          <Button
            type="button"
            onClick={nextSection}
            className="bg-[#EFB036] hover:bg-[#e0a030] text-white font-medium py-3 px-6 rounded-lg transition-all hover:-translate-y-0.5 shadow-md hover:shadow-lg"
          >
            Next: Review
          </Button>
        </div>
      </div>
    );
  } 