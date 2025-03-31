// Apply for a job
import Image from "next/image";
import Link from "next/link";
import { CustomImage } from "@/components/ui/Images/Image";

export default function ApplySection() {
    return (
        <section className="bg-light py-20 px-6" style={{ backgroundColor: "#F5F5F5" }}>
            <div className="container mx-auto flex flex-col-reverse lg:flex-row items-center gap-12">

                <div className="lg:w-1/2 text-center lg:text-left">
                    <h2 className="text-4xl font-extrabold text-primary mb-4 leading-snug" style={{ color: "#6A1B9A" }}>
                        Looking for a Job?
                    </h2>

                    <p className="text-lg text-dark mb-6" style={{ color: "#212121" }}>
                        Join one of the fastest growing home services platforms and work as a:
                    </p>

                    <ul className="text-dark mb-6 space-y-3" style={{ color: "#212121" }}>
                        <li className="flex items-center gap-2">
                            <span className="text-warning text-xl" style={{ color: "#FFA726" }}>🔧</span>
                            Plumber, Electrician, Cleaner, AC Technician & more
                        </li>
                        <li className="flex items-center gap-2">
                            <span className="text-warning text-xl" style={{ color: "#FFA726" }}>⏰</span>
                            Work when you want – full-time or part-time
                        </li>
                        <li className="flex items-center gap-2">
                            <span className="text-warning text-xl" style={{ color: "#FFA726" }}>📍</span>
                            Get clients directly in your area
                        </li>
                        <li className="flex items-center gap-2">
                            <span className="text-warning text-xl" style={{ color: "#FFA726" }}>✅</span>
                            Quick & free registration process
                        </li>
                    </ul>

                    <div className="mb-6">
                        <span className="inline-block text-sm font-semibold px-3 py-1 rounded-full"
                            style={{ backgroundColor: "#FFFFFF", color: "#4CAF50" , fontWeight: "bold" }}
                        >
                            Start working as soon as tomorrow!
                        </span>
                    </div>

                    <Link
                        href="/register"
                        className="inline-block font-bold px-8 py-3 rounded-xl shadow-lg transition duration-300"
                        style={{ backgroundColor: "#FFA726", color: "#23486A" }}
                    >
                        Apply Now
                    </Link>
                </div>

                <div className="lg:w-1/2 flex justify-center">
                    <CustomImage
                        src="/images/4.png"
                        alt="Construction worker illustration"
                        width={500}
                        height={500}
                        className="rounded-xl shadow-xl"
                    />
                </div>
            </div>
        </section>
    );
}
