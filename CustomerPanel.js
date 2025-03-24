import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from '../components/common/Header';
import Footer from '../components/common/Footer';
import './CustomerPanel.css';

function CustomerPanel() {
  const [vehicles, setVehicles] = useState([]);
  const [userId, setUserId] = useState(null);
  const [userName, setUserName] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    checkAuthentication();
  }, []);

  const checkAuthentication = () => {
    const loggedInUserId = localStorage.getItem('userId');
    const loggedInUserName = localStorage.getItem('userName');

    if (!loggedInUserId) {
      navigate('/login'); // Redirect to login if not authenticated
      return;
    }

    setUserId(loggedInUserId);
    setUserName(loggedInUserName || 'Guest');
    setIsLoading(false);
  };

  useEffect(() => {
    const fetchVehicles = async () => {
      try {
        console.log('Fetching vehicles...');
        const response = await fetch('http://localhost:5000/api/vehicles');
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        console.log('Fetched vehicles:', data);
        setVehicles(data);
      } catch (error) {
        console.error('Error fetching vehicles:', error);
      }
    };

    fetchVehicles();
  }, []);

  const handleBook = async (vehicleId) => {
    try {
      if (!userId) {
        alert('Please log in to book a vehicle');
        navigate('/login');
        return;
      }

      console.log('Booking vehicle with ID:', vehicleId);

      const bookingData = {
        userId: parseInt(userId),
        vehicleId: parseInt(vehicleId),
        bookingDate: new Date().toISOString(),
      };

      const response = await fetch('http://localhost:5000/api/book', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(bookingData),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'Failed to book vehicle');
      }

      alert('Vehicle booked successfully!');
      setVehicles((prevVehicles) =>
        prevVehicles.filter((vehicle) => vehicle.VID !== vehicleId)
      );
    } catch (error) {
      console.error('Error booking vehicle:', error);
      alert(error.message || 'Failed to book vehicle. Please try again.');
    }
  };

  if (isLoading) {
    return <div>Loading...</div>;
  }

  return (
    <div>
      <Header userName={userName} /> {/* Pass userName to Header */}
      <div className="vehicle-list-container">
        <h1 className="page-title">Welcome, {userName}!</h1>
        <h2 className="vehicle-list-title">Available Vehicles</h2>
        {vehicles.length === 0 ? (
          <p className="no-vehicles">No vehicles available</p>
        ) : (
          <div className="vehicle-cards">
            {vehicles.map((vehicle) => (
              <div key={vehicle.VID} className="vehicle-card">
                <h3 className="vehicle-title">
                  {vehicle.make} {vehicle.model}
                </h3>
                <p className="vehicle-detail">Year: {vehicle.year}</p>
                <p className="vehicle-detail">Price: ₹{vehicle.price.toLocaleString()}</p>
                <p className="vehicle-detail">Color: {vehicle.color}</p>
                <button
                  className="book-button"
                  onClick={() => handleBook(vehicle.VID)}
                >
                  Book Now
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
      <Footer />
    </div>
  );
}

export default CustomerPanel;
