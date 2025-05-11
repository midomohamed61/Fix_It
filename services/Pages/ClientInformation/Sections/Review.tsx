import { Button } from "@/components/ui/Button/Button";
import { Input } from "@/components/ui/Form/Input";
import { Label } from "@/components/ui/Form/Label";

export default function Review({
    formData,
    errors,
    imagePreviews,
    handleChange,
    prevSection,
    submitForm
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
    handleChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
    prevSection: () => void;
    submitForm: () => void;
  }) {
    const formatDate = (dateStr: string | number | Date) => {
      if (!dateStr) return '';
      const date = new Date(dateStr);
      return date.toLocaleDateString('en-GB');
    };
  
    return (
      <div className="form-section  ">
        <h2 className="text-2xl font-semibold text-[#3B6790] mb-5 pb-2 border-b-2 border-[#EFB036]">
          Review Your Information
        </h2>
        
        <div className="flex flex-wrap -mx-4 mb-5">
          <div className="w-full px-4 mb-5">
            <h3 className="text-xl font-semibold mb-4 text-[#EFB036]">Preview Client ID Card</h3>
            <div className="id-card-preview bg-gradient-to-br from-[#3B6790] to-[#23486A] rounded-xl p-5 text-white w-full max-w-md mx-auto shadow-lg relative overflow-hidden">
              <div className="shine absolute top-0 left-0 w-1/2 h-full bg-gradient-to-r from-transparent via-white/30 to-transparent animate-shine"></div>
              <div className="id-card-header flex justify-between items-center mb-5">
                <div className="id-card-logo font-bold text-xl text-[#EFB036]">CLIENT PORTAL</div>
                <div className="id-card-number bg-white/10 py-1 px-3 rounded text-sm">
                  ID: {formData.idNumber || 'xxxxxxxx'}
                </div>
              </div>
              <div className="id-card-photo w-24 h-24 bg-white rounded overflow-hidden float-left mr-4">
                {imagePreviews.profilePhoto ? (
                  <img
                    src={imagePreviews.profilePhoto.preview}
                    alt="Profile Photo"
                    className="w-full h-full object-cover"
                  />
                ) : (
                  <div className="w-full h-full bg-gray-200 flex items-center justify-center">
                    <span className="text-3xl">👤</span>
                  </div>
                )}
              </div>
              <div className="id-card-details overflow-hidden">
                <p className="name text-lg font-bold mb-2">
                  {formData.firstName || 'First'} {formData.lastName || 'Last'}
                </p>
                <p>DOB: {formatDate(formData.dob) || 'DD/MM/YYYY'}</p>
                <p>Nationality: {formData.nationality || '-------'}</p>
                <p>ID Type: {formData.idType || 'Unknown'}</p>
              </div>
              <div className="id-card-footer clear-both mt-4 pt-4 border-t border-white/20 text-center text-sm">
                <p>Valid until <span>{formatDate(formData.expiryDate) || 'DD/MM/YYYY'}</span></p>
              </div>
            </div>
          </div>
        </div>
  
        <div className="flex flex-wrap -mx-4 mb-5">
          <div className="w-full md:w-1/2 px-4 mb-5">
            <h3 className="text-xl font-semibold mb-4 text-[#EFB036]">Personal & Contact Information</h3>
            <div className="bg-[#FEF3E2] p-4 rounded-lg">
              <p>
                <strong>Name:</strong> {formData.firstName} {formData.lastName}<br />
                <strong>Date of Birth:</strong> {formData.dob}<br />
                <strong>Gender:</strong> {formData.gender || 'Not specified'}<br />
                <strong>Nationality:</strong> {formData.nationality || 'Not specified'}<br />
                <strong>Occupation:</strong> {formData.occupation || 'Not specified'}<br />
                <strong>Email:</strong> {formData.email}<br />
                <strong>Phone:</strong> {formData.phone}<br />
                <strong>Address:</strong> {formData.address}, {formData.city}, 
                {formData.state && ` ${formData.state},`} {formData.zipCode}, {formData.country}
              </p>
            </div>
          </div>
          <div className="w-full md:w-1/2 px-4 mb-5">
            <h3 className="text-xl font-semibold mb-4 text-[#EFB036]">Identification Details</h3>
            <div className="bg-[#FEF3E2] p-4 rounded-lg">
              <p>
                <strong>ID Type:</strong> {formData.idType || 'Not specified'}<br />
                <strong>ID Number:</strong> {formData.idNumber}<br />
                <strong>Issue Date:</strong> {formData.issueDate || 'Not specified'}<br />
                <strong>Expiry Date:</strong> {formData.expiryDate}<br />
                <strong>Issuing Authority:</strong> {formData.issuingAuthority}<br />
                <strong>Issuing Country:</strong> {formData.issuingCountry}
              </p>
            </div>
          </div>
        </div>
  
        <div className="flex flex-wrap -mx-4 mb-5">
          <div className="w-full px-4 mb-5">
            <h3 className="text-xl font-semibold mb-4 text-[#EFB036]">Uploaded Documents</h3>
            <div className="bg-[#FEF3E2] p-4 rounded-lg">
              <p>
                {formData.profilePhoto ? (
                  <>✅ Profile Photo: {formData.profilePhoto.name}</>
                ) : (
                  <>❌ Profile Photo: Missing</>
                )}
              </p>
              <p>
                {formData.idFront ? (
                  <>✅ ID Front: {formData.idFront.name}</>
                ) : (
                  <>❌ ID Front: Missing</>
                )}
              </p>
              <p>
                {formData.idBack ? (
                  <>✅ ID Back: {formData.idBack.name}</>
                ) : (
                  <>ID Back: Not provided (optional)</>
                )}
              </p>
              <p>
                {formData.additionalDocs && formData.additionalDocs.length > 0 ? (
                  <>✅ Additional Documents: {formData.additionalDocs.length} file(s)</>
                ) : (
                  <>Additional Documents: None provided (optional)</>
                )}
              </p>
              {formData.additionalDocs &&
                formData.additionalDocs.map((doc, index) => (
                  <p key={index} className="pl-4">
                    - {doc.name}
                  </p>
                ))}
            </div>
          </div>
        </div>
  
        <div className="flex flex-wrap -mx-4 mb-5">
          <div className="w-full px-4 mb-5">
            <Label htmlFor="confirmation" className="flex items-start">
              <Input
                type="checkbox"
                id="confirmation"
                name="confirmation"
                checked={formData.confirmation}
                onChange={handleChange}
                className={`mt-1 mr-2 ${errors.confirmation ? 'animate-shake' : ''}`}
                required
              />
              <span className="text-l text-[#EFB036]" >
                I confirm that all the information provided is accurate and complete.
              </span>
            </Label>
            {errors.confirmation && (
              <p className="text-red-500 text-sm mt-1">{errors.confirmation}</p>
            )}
          </div>
        </div>
  
        <div className="flex justify-between mt-8">
          <Button
            type="button"
            onClick={prevSection}
            className="bg-transparent border border-[#23486A] text-[#23486A] hover:bg-[#4C7B8B] hover:text-white font-medium py-3 px-6 rounded-lg transition-all"
          >
            Previous
          </Button>
          <Button
            type="button"
            onClick={submitForm}
            className="bg-[#EFB036] hover:bg-[#e0a030] text-white font-medium py-3 px-6 rounded-lg transition-all hover:-translate-y-0.5"
          >
            Submit Information
          </Button>
        </div>
      </div>
    );
  }