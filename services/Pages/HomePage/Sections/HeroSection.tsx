
function HeroSection() {

  return (
    <section
      className="flex flex-col w-full justify-around items-center max-h-[750px] min-h-[calc(100vh-80px)]"
      id="Hero"
    >
      <div className="relative flex justify-between gap-9 items-center w-full">
        <div className="w-full md:w-3/5 flex flex-col 
        gap-3
        xl:gap-6
        
        ">
          <h2
            className="
          text-4xl
          md:text-5xl
          lg:text-6xl
          xl:text-7xl
          font-bold uppercase text-pretty"
          >
            TECH TALENT FAIR <br />
            Community
          </h2>
          <p className="
            text-gray-400
            text-lg
            xl:text-xl
            
            ">
            Tech Talent is a vibrant community created specifically for the
            Computer Science department within the Faculty of Science at Cairo
            University.<br /> Our mission is to assist students in navigating the
            ever-evolving world of technology and to prepare them for the
            competitive job market.
          </p>
            
        </div>
        
       </div>
    </section>
  );
}

export default HeroSection;
