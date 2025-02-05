function getGreetingBasedOnTime(currentTime) {
    const hours = currentTime.getHours();

    if (hours < 12) {
        return "Good morning.";
    } else if (hours >= 12 && hours < 17) {
        return "Good afternoon.";
    } else if (hours >= 17 && hours < 21) {
        return "Good evening.";
    } else {
        return "Good night.";
    }
}

function getCurrentWeekDays() {
    const currentDate = new Date();
    const currentDay = currentDate.getDay(); // Get the current day (0 = Sunday, 6 = Saturday)
    const mondayOffset = currentDay === 0 ? -6 : 1 - currentDay; // Calculate Monday offset
    const weekDays = [];
   
    // Loop to get Monday to Saturday
    for (let i = 0; i < 6; i++) {
      const date = new Date();
      date.setDate(currentDate.getDate() + mondayOffset + i);
      const shortDayName = date.toLocaleDateString('en-US', { weekday: 'short' });
      const formattedDate = date.getDate();
      weekDays.push({ day: shortDayName.toLowerCase(), date: formattedDate,full_date: date, isToday:  currentDate.getDate()==formattedDate});
    }
   
    return weekDays;
}

function getWeekStartAndEndDates(fetchedDate) {
    const currentDate = new Date(fetchedDate);
    const currentDay = currentDate.getDay(); // Get the current day (0 = Sunday, 6 = Saturday)

    // Calculate the offset for Monday and Saturday
    const mondayOffset = currentDay === 0 ? -6 : 1 - currentDay;
    const saturdayOffset = currentDay === 0 ? -1 : 6 - currentDay;

    // Calculate Monday and Saturday dates
    const mondayDate = new Date(currentDate);
    mondayDate.setDate(currentDate.getDate() + mondayOffset);

    const saturdayDate = new Date(currentDate);
    saturdayDate.setDate(currentDate.getDate() + saturdayOffset);

    // Create objects for start_date (Monday) and end_date (Saturday)
    

    return { mondayDate, saturdayDate };
}

function countConsecutive(arr) {
    let count = 0;
    arr.sort((a, b) => b - a);

    for (let i = 0; i < arr.length - 1; i++) {
        // Check if the difference between adjacent elements is 1
        if (Math.abs(arr[i] - arr[i + 1]) === 1) {
            count++;
        } else {
            break;
        }
    }

    return count;
}

   

module.exports = { getGreetingBasedOnTime, getCurrentWeekDays, getWeekStartAndEndDates, countConsecutive };
