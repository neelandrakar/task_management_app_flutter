// Function to determine the type of input
const identifyInputType = (input) => {

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^\d{10}$/; // Adjust this regex based on your phone number format
  
    if (emailRegex.test(input)) {
      return 'email';
    } else if (phoneRegex.test(input)) {
      return 'mobno';
    } else {
      return 'username'; // Default to username if it doesn't match email or mobno
    }
  };

const fetchUsername = (user_id) => {

}  
  
  module.exports = { 
    identifyInputType,
    fetchUsername
   };