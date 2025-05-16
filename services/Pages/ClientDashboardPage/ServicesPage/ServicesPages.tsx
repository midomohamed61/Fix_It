"use client";

import React, { useState, useEffect } from 'react';
import { FaClock, FaCheck, FaSyncAlt, FaTools } from 'react-icons/fa';
import { Button } from '@/components/ui/Button/Button';
import SectionHeading from '@/components/ui/SectionHeading';
import { LoadingSkeleton } from '@/components/ui/LoadingSkeleton';
import Link from 'next/link';

export default function ServicesPage() {
  const [isLoading, setIsLoading] = useState(true);
  const [activeFilter, setActiveFilter] = useState('All Services');

  const services = [
    {
      id: 1,
      title: 'Bathroom Remodel',
      description: 'Complete renovation of master bathroom with new fixtures',
      status: 'In Progress',
      startDate: '2023-04-01',
      estimatedCompletion: '2023-04-15',
      provider: 'Teresa Williams',
      cost: '$2,400',
    },
    {
      id: 2,
      title: 'Kitchen Sink Repair',
      description: 'Fix leaking pipes and replace faucet',
      status: 'Scheduled',
      startDate: '2023-04-10',
      estimatedCompletion: '2023-04-10',
      provider: 'Dan Peters',
      cost: '$350',
    },
    {
      id: 3,
      title: 'HVAC Maintenance',
      description: 'Annual checkup and filter replacement',
      status: 'Completed',
      startDate: '2023-03-20',
      estimatedCompletion: '2023-03-20',
      provider: 'Rio Ronnie',
      cost: '$180',
    },
  ];

  useEffect(() => {
    // Simulate data fetching
    const timer = setTimeout(() => setIsLoading(false), 2000);
    return () => clearTimeout(timer);
  }, []);

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'In Progress':
        return <FaClock size={16} className="text-blue-400" />;
      case 'Scheduled':
        return <FaSyncAlt size={16} className="text-yellow-400" />;
      case 'Completed':
        return <FaCheck size={16} className="text-green-400" />;
      default:
        return <FaTools size={16} className="text-gray-400" />;
    }
  };

  const getStatusClass = (status: string) => {
    switch (status) {
      case 'In Progress':
        return 'bg-blue-900 text-blue-100';
      case 'Scheduled':
        return 'bg-yellow-900 text-yellow-100';
      case 'Completed':
        return 'bg-green-900 text-green-100';
      default:
        return 'bg-gray-800 text-gray-100';
    }
  };

  const filteredServices = activeFilter === 'All Services'
    ? services
    : services.filter(service => service.status === activeFilter);

  return (
    <div className="p-4 sm:p-6 lg:p-8 text-[#F5EEDC] bg-[#23486A] min-h-screen">
      <SectionHeading title="My Services" />
      
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8 gap-4">
        <div className="flex flex-wrap gap-2 sm:gap-4">
          {['All Services', 'In Progress', 'Scheduled', 'Completed'].map((filter) => (
            <Button
              key={filter}
              className={`px-4 py-2 rounded-lg transition-colors duration-300 ${
                activeFilter === filter
                  ? 'bg-[#EFB036] text-[#23486A]'
                  : 'bg-[#3B6790] hover:bg-[#EFB036] hover:text-[#23486A]'
              }`}
              onClick={() => setActiveFilter(filter)}
            >
              {filter}
            </Button>
          ))}
        </div>
        <Button className="bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] px-4 py-2 rounded-lg transition-transform duration-300 hover:scale-105">
          Request New Service
        </Button>
      </div>
      
      {isLoading ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {[...Array(3)].map((_, index) => (
            <LoadingSkeleton
              key={index}
              className="bg-[#3B6790]/50"
              height={300}
              rounded="lg"
            />
          ))}
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredServices.map((service) => (
            <div
              key={service.id}
              className="bg-[#3B6790] rounded-xl p-6 transition-transform duration-300 hover:scale-105"
            >
              <div className="flex justify-between items-start mb-4">
                <div>
                  <h2 className="text-lg sm:text-xl font-semibold text-[#EFB036]">
                    {service.title}
                  </h2>
                  <p className="text-[#F5EEDC] mt-1 text-sm sm:text-base">{service.description}</p>
                </div>
                <span className={`px-3 py-1 rounded-full text-sm flex items-center space-x-1  ${getStatusClass(service.status)}`}>
                  {getStatusIcon(service.status)}
                  <span>{service.status}</span>
                </span>
              </div>
              
              <div className="grid grid-cols-1 gap-4 mt-4">
                <div>
                  <p className="text-[#B0E0E6] text-sm">Service Provider</p>
                  <p className="font-medium text-[#F5EEDC]">{service.provider}</p>
                </div>
                <div>
                  <p className="text-[#B0E0E6] text-sm">Timeline</p>
                  <p className="font-medium text-[#F5EEDC]">{service.startDate} - {service.estimatedCompletion}</p>
                </div>
                <div>
                  <p className="text-[#B0E0E6] text-sm">Cost</p>
                  <p className="font-medium text-[#F5EEDC]">{service.cost}</p>
                </div>
              </div>
              
              <div className="flex justify-end mt-6 gap-4">
                <Link href={`/services/${service.id}`}>
                  <Button className="bg-[#23486A] hover:bg-[#EFB036] hover:text-[#23486A] px-4 py-2 rounded-lg transition-colors duration-300">
                    View Details
                  </Button>
                </Link>
                <Button className="bg-[#4C7B8B] hover:bg-[#EFB036] hover:text-[#23486A] px-4 py-2 rounded-lg transition-colors duration-300">
                  Contact Provider
                </Button>
              </div>
            </div>
          ))}
        </div>
      )}
      
      <style jsx global>{`
        @keyframes glow {
          0%, 100% {
            text-shadow: 0 0 5px #EFB036, 0 0 10px #EFB036;
          }
          50% {
            text-shadow: 0 0 10px #EFB036, 0 0 20px #EFB036;
          }
        }
        .animate-glow {
          animation: glow 2s ease-in-out infinite;
        }
      `}</style>
    </div>
  );
}