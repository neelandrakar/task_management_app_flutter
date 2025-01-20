
const getDateDifference = (date1, date2) => {

    // Create Date objects
    const startDate = new Date(date1);
    const endDate = new Date(date2);

    // Calculate the difference in milliseconds
    const diffInMilliseconds = endDate.getDate() - startDate.getDate();

    // Convert milliseconds to days
    const diffInDays = Math.floor(diffInMilliseconds / (1000 * 60 * 60 * 24));

    return diffInDays
}

module.exports = { getDateDifference }