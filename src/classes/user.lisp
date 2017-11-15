(in-package :lispcord.classes.user)


(defclass user ()
  ((id            :initarg :id
		  :type snowflake)
   (username      :initarg :username
		  :type string)
   (discriminator :initarg :discrim
		  :type string)
   (avatar        :initarg :avatar
		  :type string)
   (bot           :initarg :bot
		  :type t)
   (mfa           :initarg :mfa
		  :type t)
   (verified      :initarg :verified
		  :type t)
   (email         :initarg :email
		  :type t)))

(defmethod %to-json ((u user))
  (with-object
    (write-key-value "id" (!! u id))
    (write-key-value "username" (!! u username))
    (write-key-value "discriminator" (!! u discriminator))
    (write-key-value "avatar" (!! u avatar))
    (write-key-value "bot" (!! u bot))
    (write-key-value "mfa" (!! u mfa))
    (write-key-value "verified" (!! u verified))
    (write-key-value "email" (!! u email))))

(defmethod from-json ((c (eql :user)) (table hash-table))
  (instance-from-table (table 'user)
    :id "id"
    :username "username"
    :discrim "discriminator"
    :avatar "avatar"
    :bot "bot"
    :mfa "mfa"
    :verified "verified"
    :email "email"))


(defclass game ()
  ((name :initarg :name :type string)
   (type :initarg :type :type (integer 0 1))
   (url  :initarg :url  :type string)))

(defmethod from-json ((c (eql :game)) (table hash-table))
  (instance-from-table (table 'game)
    :name "name"
    :type "type"
    :url "url"))

(defmethod %to-json ((g game))
  (with-object
    (write-key-value "name" (!! g name))
    (write-key-value "type" (!! g type))
    (write-key-value "url" (!! g url))))

(defclass presence ()
  ((user     :initarg :user     :type user)
   (roles    :initarg :roles    :type (vector role))
   (game     :initarg :game     :type (or null game))
   (guild-id :initarg :guild-id :type snowflake)
   (status   :initarg :status   :type string)))

(defmethod from-json ((c (eql :presence)) (table hash-table))
  (instance-from-table (table 'presence)
    :user (from-json :user (gethash "user" table))
    :roles (map 'vector (curry #'from-json :role)
		(gethash "roles" table))
    :game (from-json :game (gethash "game" table))
    :guild-id "guild_id"
    :status "status"))

(defmethod %to-json ((p presence))
  (with-object
    (write-key-value "name" (!! p name))
    (write-key-value "roles" (!! p roles))
    (write-key-value "game" (!! p game))
    (write-key-value "guild_id" (!! p guild-id))
    (write-key-value "status" (!! p status))))
