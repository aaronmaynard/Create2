// Generated by gencpp from file create_msgs/PlaySong.msg
// DO NOT EDIT!


#ifndef CREATE_MSGS_MESSAGE_PLAYSONG_H
#define CREATE_MSGS_MESSAGE_PLAYSONG_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace create_msgs
{
template <class ContainerAllocator>
struct PlaySong_
{
  typedef PlaySong_<ContainerAllocator> Type;

  PlaySong_()
    : song(0)  {
    }
  PlaySong_(const ContainerAllocator& _alloc)
    : song(0)  {
  (void)_alloc;
    }



   typedef uint8_t _song_type;
  _song_type song;





  typedef boost::shared_ptr< ::create_msgs::PlaySong_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::create_msgs::PlaySong_<ContainerAllocator> const> ConstPtr;

}; // struct PlaySong_

typedef ::create_msgs::PlaySong_<std::allocator<void> > PlaySong;

typedef boost::shared_ptr< ::create_msgs::PlaySong > PlaySongPtr;
typedef boost::shared_ptr< ::create_msgs::PlaySong const> PlaySongConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::create_msgs::PlaySong_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::create_msgs::PlaySong_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::create_msgs::PlaySong_<ContainerAllocator1> & lhs, const ::create_msgs::PlaySong_<ContainerAllocator2> & rhs)
{
  return lhs.song == rhs.song;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::create_msgs::PlaySong_<ContainerAllocator1> & lhs, const ::create_msgs::PlaySong_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace create_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::create_msgs::PlaySong_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::create_msgs::PlaySong_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::create_msgs::PlaySong_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::create_msgs::PlaySong_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::create_msgs::PlaySong_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::create_msgs::PlaySong_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::create_msgs::PlaySong_<ContainerAllocator> >
{
  static const char* value()
  {
    return "eb55a5c354f06b6572d1ec46a28b6e6a";
  }

  static const char* value(const ::create_msgs::PlaySong_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xeb55a5c354f06b65ULL;
  static const uint64_t static_value2 = 0x72d1ec46a28b6e6aULL;
};

template<class ContainerAllocator>
struct DataType< ::create_msgs::PlaySong_<ContainerAllocator> >
{
  static const char* value()
  {
    return "create_msgs/PlaySong";
  }

  static const char* value(const ::create_msgs::PlaySong_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::create_msgs::PlaySong_<ContainerAllocator> >
{
  static const char* value()
  {
    return "uint8 song      # song number [0-3]\n"
;
  }

  static const char* value(const ::create_msgs::PlaySong_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::create_msgs::PlaySong_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.song);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct PlaySong_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::create_msgs::PlaySong_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::create_msgs::PlaySong_<ContainerAllocator>& v)
  {
    s << indent << "song: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.song);
  }
};

} // namespace message_operations
} // namespace ros

#endif // CREATE_MSGS_MESSAGE_PLAYSONG_H
