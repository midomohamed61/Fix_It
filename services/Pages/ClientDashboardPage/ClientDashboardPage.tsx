"use client";

import React, { useState, useEffect, useCallback, useMemo } from 'react';
import { 
  FaHome, 
  FaClock, 
  FaFileAlt, 
  FaComments, 
  FaCalendarAlt, 
  FaUserCheck, 
  FaPhone,
  FaTools,
  FaDollarSign
} from 'react-icons/fa';
import { Button } from '@/components/ui/Button/Button';
import { useRouter } from 'next/navigation';
import { HeaderSection } from '@/Pages/ClientDashboardPage/Sections/HeaderSection';
import { NavigationTabs } from '@/Pages/ClientDashboardPage/Sections/NavigationTabs';
import { ServiceProvidersSection } from '@/Pages/ClientDashboardPage/Sections/ServiceProvidersSection';
import { ActivityLogSection } from '@/Pages/ClientDashboardPage/Sections/ActivityLogSection';
import { NavigationMenu } from '@/Pages/ClientDashboardPage/Sections/NavigationMenu';
import { UpcomingServicesWidget } from '@/Pages/ClientDashboardPage/Sections/UpcomingServicesWidget';
import { NavigationItem } from './types';
import { Skeleton, SkeletonCircle } from '@/components/ui/Skeleton/Skeleton';
import { motion } from 'framer-motion';

interface ClientData {
    clientId: string;
    firstName: string;
    lastName: string;
    dob: string;
    gender: string;
    nationality: string;
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
    profilePhoto: string | null;
    idFront: string | null;
    idBack: string | null;
    additionalDocs: string[] | null;
    termsAccepted: boolean;
}

interface ServiceProvider {
    name: string;
    role: string;
    area: string;
    avatar: string;
}

interface Activity {
    task: string;
    time: string;
    payment: string;
    type: string;
    status: string;
    id: number;
}

interface UpcomingService {
    title: string;
    date: string;
    technician: string;
    status: string;
    address: string;
}

interface ServiceStats {
    activeServices: number;
    completedServices: number;
    totalSpent: number;
}

const tabs = [
  { 
    id: 'dashboard', 
    label: 'Dashboard',
    path: '/client/dashboard'
  },
  { 
    id: 'services', 
    label: 'My Services',
    path: '/client/services'
  },
  { 
    id: 'technicians', 
    label: 'My Technicians',
    path: '/client/technicians'
  },
  { 
    id: 'history', 
    label: 'Service History',
    path: '/client/history'
  }
];

// Initialize dashboard data in localStorage
const initializeDashboardData = (clientId: string) => {
    if (typeof window === 'undefined') return;

    // Initialize service providers with client-specific data
    const serviceProviders: ServiceProvider[] = [
        {
            name: 'Teresa Williams',
            role: 'Currently Working',
            area: 'Plumbing Expert',
            avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&h=120&fit=crop',
        },
        {
            name: 'Rio Ronnie',
            role: 'Scheduled Tomorrow',
            area: 'Electrical Expert',
            avatar: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=120&h=120&fit=crop',
        },
        {
            name: 'Dan Peters',
            role: 'Completed Last Week',
            area: 'HVAC Technician',
            avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=120&h=120&fit=crop',
        },
        {
            name: 'Sophia Chen',
            role: 'Available Now',
            area: 'Carpentry Expert',
            avatar: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=120&h=120&fit=crop',
        },
    ];
    localStorage.setItem(`serviceProviders_${clientId}`, JSON.stringify(serviceProviders));

    // Initialize activity log with client-specific data
    const activityLog: Activity[] = [
        {
            task: 'Plumbing repair completed',
            time: '2 hours ago',
            payment: '$120.00',
            type: 'service',
            status: 'completed',
            id: 1
        },
        {
            task: 'New appointment scheduled',
            time: 'Yesterday',
            payment: 'Pending',
            type: 'appointment',
            status: 'scheduled',
            id: 2
        },
        {
            task: 'Technician feedback submitted',
            time: '3 days ago',
            payment: 'N/A',
            type: 'feedback',
            status: 'completed',
            id: 3
        },
        {
            task: 'Payment processed',
            time: 'Last week',
            payment: '$85.50',
            type: 'payment',
            status: 'completed',
            id: 4
        },
    ];
    localStorage.setItem(`activityLog_${clientId}`, JSON.stringify(activityLog));

    // Initialize upcoming services with client-specific data
    const upcomingServices: UpcomingService[] = [
        {
            title: 'Bathroom Sink Repair',
            date: 'Today, 3:30 PM',
            technician: 'Teresa Williams',
            status: 'Confirmed',
            address: '123 Home Street, Apt 4B'
        },
        {
            title: 'AC Maintenance',
            date: 'Tomorrow, 10:00 AM',
            technician: 'Dan Peters',
            status: 'Pending',
            address: '123 Home Street, Apt 4B'
        },
        {
            title: 'Kitchen Lighting Installation',
            date: 'May 15, 2:00 PM',
            technician: 'Rio Ronnie',
            status: 'Confirmed',
            address: '123 Home Street, Apt 4B'
        },
    ];
    localStorage.setItem(`upcomingServices_${clientId}`, JSON.stringify(upcomingServices));

    // Initialize service statistics with client-specific data
    const serviceStats: ServiceStats = {
        activeServices: 2,
        completedServices: 12,
        totalSpent: 1285
    };
    localStorage.setItem(`serviceStats_${clientId}`, JSON.stringify(serviceStats));
};

const ClientDashboardPage = () => {
  const [activeTab, setActiveTab] = useState('dashboard');
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [clientData, setClientData] = useState<ClientData | null>(null);
  const router = useRouter();

  useEffect(() => {
    const loadClientData = () => {
      try {
        if (typeof window !== 'undefined') {
          const allKeys = Object.keys(localStorage);
          const clientKeys = allKeys.filter(key => key.startsWith('clientFormData_'));
          
          if (clientKeys.length > 0) {
            // Get the most recent client data
            const latestKey = clientKeys[clientKeys.length - 1];
            const data = JSON.parse(localStorage.getItem(latestKey) || '{}');
            const clientId = latestKey.replace('clientFormData_', '');
            
            setClientData({
              ...data,
              clientId
            });

            // Initialize dashboard data if it doesn't exist
            if (!localStorage.getItem(`serviceProviders_${clientId}`)) {
              initializeDashboardData(clientId);
            }
          } else {
            setError('No client data found. Please complete the registration form first.');
          }
        }
      } catch (err) {
        setError('Error loading client data. Please try again.');
        console.error('Error loading client data:', err);
      } finally {
        setIsLoading(false);
      }
    };

    loadClientData();
  }, []);

  const handleTabChange = useCallback((tabId: string) => {
    setActiveTab(tabId);
  }, []);

  const navigationItems = useMemo<NavigationItem[]>(() => [
    { icon: <FaHome size={20} />, label: 'Dashboard', active: activeTab === 'dashboard', route: 'dashboard', path: '/client/dashboard' },
    { icon: <FaTools size={20} />, label: 'My Services', active: activeTab === 'services', route: 'services', path: '/client/services' },
    { icon: <FaCalendarAlt size={20} />, label: 'Appointments', active: activeTab === 'appointments', route: 'appointments', path: '/client/appointments' },
    { icon: <FaComments size={20} />, label: 'Messages', active: activeTab === 'messages', route: 'messages', path: '/client/messages' },
    { icon: <FaFileAlt size={20} />, label: 'Service Requests', active: activeTab === 'requests', route: 'requests', path: '/client/requests' },
    { icon: <FaClock size={20} />, label: 'Service History', active: activeTab === 'history', route: 'history', path: '/client/history' },
    { icon: <FaUserCheck size={20} />, label: 'My Technicians', active: activeTab === 'technicians', route: 'technicians', path: '/client/technicians' },
    { icon: <FaPhone size={20} />, label: 'Support', active: activeTab === 'support', route: 'support', path: '/client/support' },
  ], [activeTab]);

  // Load service providers from localStorage
  const serviceProviders = useMemo(() => {
    if (typeof window !== 'undefined' && clientData) {
      const providersData = localStorage.getItem(`serviceProviders_${clientData.clientId}`);
      return providersData ? JSON.parse(providersData) : [];
    }
    return [];
  }, [clientData]);

  // Load activity log from localStorage
  const activityLog = useMemo(() => {
    if (typeof window !== 'undefined' && clientData) {
      const activityData = localStorage.getItem(`activityLog_${clientData.clientId}`);
      return activityData ? JSON.parse(activityData) : [];
    }
    return [];
  }, [clientData]);

  // Load upcoming services from localStorage
  const upcomingServices = useMemo(() => {
    if (typeof window !== 'undefined' && clientData) {
      const servicesData = localStorage.getItem(`upcomingServices_${clientData.clientId}`);
      return servicesData ? JSON.parse(servicesData) : [];
    }
    return [];
  }, [clientData]);

  // Calculate service statistics
  const serviceStats = useMemo(() => {
    if (typeof window !== 'undefined' && clientData) {
      const statsData = localStorage.getItem(`serviceStats_${clientData.clientId}`);
      return statsData ? JSON.parse(statsData) : {
        activeServices: 0,
        completedServices: 0,
        totalSpent: 0
      };
    }
    return {
      activeServices: 0,
      completedServices: 0,
      totalSpent: 0
    };
  }, [clientData]);

  if (error) {
    return (
      <div className="min-h-screen bg-[#23486A] text-[#F5EEDC] p-6 flex items-center justify-center">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-[#3B6790] rounded-xl p-6 max-w-md w-full text-center"
        >
          <h2 className="text-xl font-semibold mb-4">Error Loading Dashboard</h2>
          <p className="mb-6">{error}</p>
          <Button 
            className="bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] font-medium"
            onClick={() => router.push('/services/client-information')}
          >
            Go to Registration
          </Button>
        </motion.div>
      </div>
    );
  }

  if (isLoading) {
    return <LoadingSkeleton />;
  }

  if (!clientData) {
    return (
      <div className="min-h-screen bg-[#23486A] text-[#F5EEDC] p-6 flex items-center justify-center">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-[#3B6790] rounded-xl p-6 max-w-md w-full text-center"
        >
          <h2 className="text-xl font-semibold mb-4">No Client Data Found</h2>
          <p className="mb-6">Please complete the client registration form first.</p>
          <Button 
            className="bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] font-medium"
            onClick={() => router.push('/services/client-information')}
          >
            Go to Registration
          </Button>
        </motion.div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#23486A] text-[#EFB036] p-4 md:p-6">
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 0.5 }}
      >
        <HeaderSection 
          title={`${clientData.firstName} ${clientData.lastName}`}
          subtitle="Manage your service requests and technicians"
          profileImage={clientData.profilePhoto || undefined}
        />
      </motion.div>

      <NavigationTabs 
        tabs={tabs}
        activeTab={activeTab}
        onChange={handleTabChange}
      />
      
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-4 md:gap-6 mt-6">
        <div className="lg:col-span-8 space-y-4 md:space-y-6">
          {/* Service Providers Section */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.1 }}
          >
            <ServiceProvidersSection 
              title="My Service Providers" 
              providers={serviceProviders} 
            />
          </motion.div>
          
          {/* Recent Activity */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.2 }}
          >
            <ActivityLogSection activities={activityLog} />
          </motion.div>
          
          {/* Service Status Summary */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.3 }}
          >
            <div className="bg-[#3B6790] rounded-xl p-6">
              <h2 className="text-4xl font-semibold mb-4 text-[#EFB036]">Service Status</h2>
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                <StatusCard
                  title="Active Services" 
                  value={serviceStats.activeServices.toString()}
                  icon={<FaTools size={24} color="#F5EEDC" />} 
                  color='#EFB036'
                />
                <StatusCard 
                  title="Completed Services"
                  value={serviceStats.completedServices.toString()}
                  icon={<FaClock size={24} color="#F5EEDC" />}
                  color="#EFB036"
                />
                <StatusCard
                  title="Total Spent" 
                  value={`$${serviceStats.totalSpent}`}
                  icon={<FaDollarSign size={24} color="#F5EEDC" />}
                  color="#EFB036"
                />
              </div>
            </div>
          </motion.div>
        </div>

        <div className="lg:col-span-4 space-y-4 md:space-y-6">
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.1 }}
          >
            <div className="bg-[#3B6790] rounded-xl p-6">
              <NavigationMenu 
                items={navigationItems} 
                onNavItemClick={(item) => router.push(item.path || item.label.toLowerCase())} 
              />
            </div>
          </motion.div>
          
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.2 }}
          >
            <UpcomingServicesWidget services={upcomingServices} />
          </motion.div>
          
          {/* Quick Actions */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.3 }}
          >
            <div className="bg-[#3B6790] rounded-xl p-6">
              <h2 className="text-xl font-semibold mb-4 text-[#F5EEDC]">Quick Actions</h2>
              <div className="space-y-3">
                <Button 
                  className="w-full bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A] font-medium"
                  onClick={() => router.push('/services/request-service')}
                >
                  Request New Service
                </Button>
                <Button 
                  className="w-full bg-[#4C7B8B] hover:bg-[#3f6673] text-[#F5EEDC] font-medium"
                  onClick={() => router.push('/client/services')}
                >
                  View All Services
                </Button>
              </div>
            </div>
          </motion.div>
        </div>
      </div>
    </div>
  );
};

const LoadingSkeleton = () => (
  <div className="space-y-6">
    {/* Header Skeleton */}
    <div className="flex justify-between items-center mb-8">
      <div className="flex items-center space-x-4">
        <SkeletonCircle size="96px" />
        <div className="space-y-2">
          <Skeleton className="h-8 w-48" />
          <Skeleton className="h-4 w-64" />
          <Skeleton className="h-6 w-32" />
        </div>
      </div>
      <div className="flex items-center space-x-6">
        <div className="space-y-2">
          <Skeleton className="h-4 w-24" />
          <Skeleton className="h-8 w-32" />
        </div>
        <div className="flex space-x-4">
          <SkeletonCircle size="40px" />
          <SkeletonCircle size="40px" />
        </div>
      </div>
    </div>

    {/* Tabs Skeleton */}
    <div className="bg-[#3B6790] rounded-lg p-2 mb-6">
      <div className="flex space-x-2">
        {[...Array(4)].map((_, i) => (
          <Skeleton key={i} className="h-10 w-24" />
        ))}
      </div>
    </div>

    <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
      <div className="lg:col-span-8 space-y-6">
        {/* Service Providers Skeleton */}
        <div className="bg-[#3B6790] rounded-xl p-6">
          <Skeleton className="h-6 w-48 mb-4" />
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {[...Array(4)].map((_, i) => (
              <div key={i} className="bg-[#23486A] rounded-lg p-4">
                <div className="flex items-start justify-between">
                  <div className="flex items-center space-x-3">
                    <SkeletonCircle size="48px" />
                    <div className="space-y-2">
                      <Skeleton className="h-4 w-32" />
                      <Skeleton className="h-3 w-24" />
                      <Skeleton className="h-3 w-20" />
                    </div>
                  </div>
                  <div className="flex space-x-2">
                    <SkeletonCircle size="32px" />
                    <SkeletonCircle size="32px" />
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Activity Log Skeleton */}
        <div className="bg-[#3B6790] rounded-xl p-6">
          <Skeleton className="h-6 w-48 mb-4" />
          <div className="space-y-4">
            {[...Array(4)].map((_, i) => (
              <div key={i} className="flex items-center justify-between p-3">
                <div className="flex items-center space-x-3">
                  <SkeletonCircle size="20px" />
                  <Skeleton className="h-4 w-48" />
                </div>
                <div className="flex items-center space-x-4">
                  <Skeleton className="h-4 w-16" />
                  <Skeleton className="h-4 w-12" />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Service Status Skeleton */}
        <div className="bg-[#3B6790] rounded-xl p-6">
          <Skeleton className="h-6 w-48 mb-4" />
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
            {[...Array(3)].map((_, i) => (
              <div key={i} className="bg-[#23486A] rounded-lg p-4">
                <div className="flex justify-between items-center">
                  <div>
                    <Skeleton className="h-4 w-24 mb-2" />
                    <Skeleton className="h-6 w-16" />
                  </div>
                  <SkeletonCircle size="48px" />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="lg:col-span-4 space-y-6">
        {/* Navigation Menu Skeleton */}
        <div className="bg-[#3B6790] rounded-xl p-6">
          <div className="space-y-2">
            {[...Array(8)].map((_, i) => (
              <Skeleton key={i} className="h-12 w-full" />
            ))}
          </div>
        </div>

        {/* Upcoming Services Skeleton */}
        <div className="bg-[#3B6790] rounded-xl p-6">
          <Skeleton className="h-6 w-48 mb-4" />
          <div className="space-y-4">
            {[...Array(3)].map((_, i) => (
              <div key={i} className="bg-[#23486A] p-4 rounded-lg">
                <div className="flex justify-between items-start mb-2">
                  <Skeleton className="h-5 w-32" />
                  <Skeleton className="h-5 w-16" />
                </div>
                <div className="space-y-2 mt-3">
                  <Skeleton className="h-4 w-full" />
                  <Skeleton className="h-4 w-full" />
                  <Skeleton className="h-4 w-full" />
                </div>
              </div>
            ))}
          </div>
          <Skeleton className="h-4 w-full mt-4" />
        </div>

        {/* Quick Actions Skeleton */}
        <div className="bg-[#3B6790] rounded-xl p-6">
          <Skeleton className="h-6 w-48 mb-4" />
          <div className="grid grid-cols-1 gap-3">
            <Skeleton className="h-10 w-full" />
            <Skeleton className="h-10 w-full" />
            <Skeleton className="h-10 w-full" />
          </div>
        </div>
      </div>
    </div>
  </div>
);

const StatusCard = ({ title, value, icon, color }: { 
  title: string; 
  value: string; 
  icon: React.ReactNode;
  color: string;
}) => (
  <motion.div 
    whileHover={{ scale: 1.03 }}
    className="bg-[#23486A] rounded-lg p-4 flex justify-between items-center"
  >
    <div>
      <p className="text-sm text-[#F5EEDC] opacity-80">{title}</p>
      <p className="text-2xl font-bold text-[#F5EEDC]">{value}</p>
    </div>
    <div className="p-3 rounded-full" style={{ backgroundColor: color, opacity: 0.2 }}>
      <div className="opacity-100" style={{ color }}>{icon}</div>
    </div>
  </motion.div>
);

export default React.memo(ClientDashboardPage);