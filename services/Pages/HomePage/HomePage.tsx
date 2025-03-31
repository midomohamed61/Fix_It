
import ApplySection from "./Sections/ApplySection";
import HeroSection from "./Sections/HeroSection"
import MainSection from "./Sections/MainSection";
import OurPartnersSection from "./Sections/OurPartnersSection";
import OurServices from "./Sections/OurServices";
import StatsSection from "./Sections/StatsSection";
import TestimonialsSection from "./Sections/TestimonialsSection";



export default function HomePage() {
  return (
    <>
      <MainSection/>
      <HeroSection />
      <OurServices/>
      <StatsSection/>
      {/* <UpcomingEventsSection /> */}
      <OurPartnersSection/>
      <TestimonialsSection/>
      <ApplySection/>
      {/* <ProjectsSection /> */}
    </>
  );
}
