const socketIO = require('socket.io');
 
const initSocket = (server) => {
  const io = socketIO(server, { cors: { origin: '*' } });
 
  var chatRoomId = '';
 
  io.on('connection', (socket) => {
    socket.on('/join_room', (roomName) => {
      chatRoomId = roomName;
      socket.join(chatRoomId);
      console.log(`user has joined ${roomName}`);

    });
   
    socket.on('/leave_room', (roomName) => {
      socket.leave(roomName);
      console.log("-------------------------");
      console.log(`user has left ${roomName}`);
    });

    socket.on('/test_xxx', (roomName) => {
        console.log("-------------------------");
        console.log(`calling test room`);
      });

   
    socket.on('/send_message', (msg) => {
      // Handle the message and broadcast it to the room
      const message = {
        _id: chatRoomId,
        text: msg.text,
        sender: msg.sender,
        sent_on: new Date(),
        receiver: msg.receiver,
        d_status: 0,
        read: false,
        attachments: attachments
      };
      console.log(message);
      io.emit('message', message);
    });
  });



  // Additional endpoint for connecting the socket
  io.of('/connect-socket').on('connection', (socket) => {
    console.log('Socket connected via /connect-socket');
    // You can perform additional socket initialization here if needed
  });

  return io;
};
 
module.exports = { initSocket };