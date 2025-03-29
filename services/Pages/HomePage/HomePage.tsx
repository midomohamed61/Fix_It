import HeroSection from "./Sections/HeroSection"
import OurPartnersSection from "./Sections/OurPartnersSection";
import TestimonialsSection from "./Sections/TestimonialsSection";



export default function HomePage() {
  return (
    <>
      <HeroSection />
      {/* <UpcomingEventsSection /> */}
      <OurPartnersSection/>
      <TestimonialsSection/>
      {/* <ProjectsSection /> */}
    </>
  );
}
