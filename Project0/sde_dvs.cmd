;; ---------------------------------------------------------------------
;;
;;              ECE 335 Project 0
;;
;; ---------------------------------------------------------------------

;;----------------------------------------------------------------------
(sde:clear)

; ---------------------------------------------------------------------
; ### Defined Parameters ###
; ---------------------------------------------------------------------

; > Dimensions <
(define tSub @tncSi@) ; um, thickness of the substrate

; > others <
(define node "@node@")

; ---------------------------------------------------------------------
; ### Creating The Structure ###
; ---------------------------------------------------------------------

(sdegeo:set-default-boolean "ABA") ; new will replace old

; > n type cSi layer <
(sdegeo:create-rectangle (position 0 0 0) (position 10 tSub 0) "Silicon" "Subs" )

; ---------------------------------------------------------------------
; ### Placing Contacts
; ---------------------------------------------------------------------
; > Electrode 1 < 
(sdegeo:define-contact-set "electrode_1" 4  (color:rgb 1 0 0 ) "solid" )
(sdegeo:define-2d-contact (find-edge-id (position 5 0 0) ) "electrode_1")

; > Electrode 2 < 
(sdegeo:define-contact-set "electrode_2" 4  (color:rgb 0 1 0 ) "||" )
(sdegeo:define-2d-contact (find-edge-id (position 5 tSub 0) ) "electrode_2")

; ---------------------------------------------------------------------
; ### Setting The Doping ###
; ---------------------------------------------------------------------

; > n region constant doping <
(sdedr:define-constant-profile "Const.Subs"  "PhosphorusActiveConcentration" 4.4e15)
(sdedr:define-constant-profile-region "PlaceCD.Subs"  "Const.Subs" "Subs")

; > n+ region  <
(sdedr:define-gaussian-profile "doping.profile.nplusSi" "PhosphorusActiveConcentration" "PeakPos" 0 "PeakVal" 4.4e17 "ValueAtDepth" 2e17 "Depth" 0.25 "Gauss" "Factor" 1)
; Window Selection
(sdedr:define-refeval-window "window.nplusSi" "Line" (position 0 0 0) (position 10 0 0))
; Doping Placement
(sdedr:define-analytical-profile-placement "place.nplusSi" "doping.profile.nplusSi"  "window.nplusSi" "Positive" "NoReplace")
; Doping Placement
(sdedr:define-analytical-profile-placement "place.nplusSi" "doping.profile.nplusSi"  "window.nplusSi" "Positive" "NoReplace")

; ---------------------------------------------------------------------
; ### Refinement
; ---------------------------------------------------------------------
; on nSi
(sdedr:define-refeval-window "refw.ncSi" "Rectangle" (position 0 0 0) (position 10 tSub 0) )
(sdedr:define-multibox-size "refs.ncSi" 1 (/ tSub 5) 0 1 (/ tSub 20) 0 1 1.1 0)
(sdedr:define-multibox-placement "Place.ncSi" "refs.ncSi" "refw.ncSi")

; on top region
(sdedr:define-refeval-window "refw.nplus" "Rectangle" (position  0 0 0) (position  10 1 0))
(sdedr:define-multibox-size "refs.nplus" 1 (/ tSub 5) 0 1 (/ tSub 100) 0 1 1.2 0)
(sdedr:define-multibox-placement "Place.nplus" "refs.nplus" "refw.nplus")

(sde:build-mesh "snmesh" "" (string-append "n" node "_msh") )

