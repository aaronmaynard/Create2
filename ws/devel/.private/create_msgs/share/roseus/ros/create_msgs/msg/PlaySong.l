;; Auto-generated. Do not edit!


(when (boundp 'create_msgs::PlaySong)
  (if (not (find-package "CREATE_MSGS"))
    (make-package "CREATE_MSGS"))
  (shadow 'PlaySong (find-package "CREATE_MSGS")))
(unless (find-package "CREATE_MSGS::PLAYSONG")
  (make-package "CREATE_MSGS::PLAYSONG"))

(in-package "ROS")
;;//! \htmlinclude PlaySong.msg.html


(defclass create_msgs::PlaySong
  :super ros::object
  :slots (_song ))

(defmethod create_msgs::PlaySong
  (:init
   (&key
    ((:song __song) 0)
    )
   (send-super :init)
   (setq _song (round __song))
   self)
  (:song
   (&optional __song)
   (if __song (setq _song __song)) _song)
  (:serialization-length
   ()
   (+
    ;; uint8 _song
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _song
       (write-byte _song s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _song
     (setq _song (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get create_msgs::PlaySong :md5sum-) "eb55a5c354f06b6572d1ec46a28b6e6a")
(setf (get create_msgs::PlaySong :datatype-) "create_msgs/PlaySong")
(setf (get create_msgs::PlaySong :definition-)
      "uint8 song      # song number [0-3]

")



(provide :create_msgs/PlaySong "eb55a5c354f06b6572d1ec46a28b6e6a")


