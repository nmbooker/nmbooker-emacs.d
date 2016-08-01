;;;; Odoo interface for Emacs

(require 'eieio)
(require 'xml-rpc)

(defclass odoo-connection ()
  ((url :initarg :url
	:type string
	:documentation "The base URL of the Odoo instance")
   (dbname :initarg :dbname
	   :type string
	   :documentation "The name of the database to connect to")
   (user :initarg :user
	 :type string
	 :documentation "The user to log in as")
   (pass :initarg :pass
	 :type string
	 :documentation "The password to log in with")
   )
  "Interface for the Odoo object interface")

(defclass odoo-object-xmlrpc (odoo-connection)
  ((uid :type number
	:documentation "the user id of the logged in user"))
  "XML-RPC implementation of the Odoo object interface")

(defmethod -odoo-xmlrpc-common-endpoint ((self odoo-object-xmlrpc))
  "Return the name of the XML-RPC common endpoint"
  (concat (oref self url) "/xmlrpc/common"))

(defmethod -odoo-xmlrpc-object-endpoint ((self odoo-object-xmlrpc))
  "Return the name of the XML-RPC object endpoint"
  (concat (oref self url) "/xmlrpc/object"))

(defmethod odoo-login ((self odoo-object-xmlrpc))
  "Log in to Odoo"
  (oset self uid (xml-rpc-method-call (-odoo-xmlrpc-common-endpoint self)
				      'login
				      (oref self dbname)
				      (oref self user)
				      (oref self pass))))

(defmethod odoo-logged-in-p ((self odoo-object-xmlrpc))
  "Whether logged in"
  (if (oref self uid) t nil))

(defmethod odoo-execute ((self odoo-object-xmlrpc) model-name method &rest args)
  "Execute a method on the given Odoo model"
  (apply 'xml-rpc-method-call
	 (-odoo-xmlrpc-object-endpoint self)
	 'execute
	 (oref self dbname)
	 (oref self uid)
	 (oref self pass)
	 model-name
	 method
	 args))

(provide 'nmb-odoo)

;; (setq test-conn (make-instance 'odoo-object-xmlrpc
;; 			       :url "http://localhost:8069"
;; 			       :dbname "oekit"
;; 			       :user "admin"
;; 			       :pass "admin"))
;; (odoo-logged-in-p test-conn)
;; (odoo-login test-conn)

;; (odoo-execute test-conn "res.partner" "fields_get")
;; (odoo-execute test-conn "res.users" "read" 1 '("id" "name" "login"))

