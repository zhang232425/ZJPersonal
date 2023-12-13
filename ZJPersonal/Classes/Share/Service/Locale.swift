//
//  Locale.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/11/30.
//

import ZJLocalizable

enum Locale: String {
    
    case requestTimeout
    case requestFailed
    case requestFailedPleaseRetry
    
    case go
    
    case main_item_rm
    case main_item_performance
    case main_item_chat
    case main_item_setting
    case main_welcome_title
    case main_welcome_desc
    case main_unlogin_btn_title
    case main_coupon_unused
    case main_go_btn_title
    case main_coupon_title
    case main_invite_title
    case chat_toplevel_faq_prefix
    case chat_phone_call_title
    case chat_phone_call_desc
    case download_telegram
    case generating_certificate
    
    //MARK: ====== 设置

    case confirm
    case markMessagesRead
    case markAllMessageReadNotice
    case settingTitle//✅
    case languageSelection//✅
    case signOut//✅
    case setLoginPassword
    case setPasswordHint
    case passwordFormatError
    case setPasswordSuccess
    case changeLoginPassword
    case changePasswordSuccess
    case newPwdCannotBeSameToOld
    case touchIdConfigItemTitle
    case faceIdConfigItemTitle
    case touchIdEvaluateReason
    case faceIdEvaluateReason
    case evaluationFailToast
    case passcodeNotSetToast
    case biometryLockoutToast
    case touchNotEnrolledToast
    case faceNotEnrolledToast
    case touchIdPasswordEnabled
    case touchIdPasswordDisabled
    case faceIdPasswordEnabled
    case faceIdPasswordDisabled
    case appVersionTitle
    case alreadyTheLatestVersion
    case clearCache
    case accountDeletion
    case logoutSuccess
    
    //MARK: ====== 个人中心首页
    
    case wealthScore//✅
    case pleaseLogin//✅
    case coupon//✅
    case task//✅
    case privilege//✅
    case login//✅
    case electronicSignature//✅
    case message//✅
    case invitationReward//✅
    case rm_baManager//✅
    case performanceManagement//✅
    case customerService//✅
    case setting//✅
    case aboutUs//✅
    
    //MARK: ====== 个人信息
    
    case userInfoTitle//✅
    
    case headPortrait//✅
    
    case nickname
    
    case authentication//✅
    
    case phoneNumber//✅
    
    case myBankCard//✅
    
    case finishCertificationAlertText//✅
    
    case passwordManagement//✅
    
    case NPWP
    
    case toAuthenticate//✅
    
    case verified//✅
    
    case authenticating//✅
    
    case locked//✅
    
    case takingPicture//✅
    
    case useDefaultAvatar//✅
    
    case rmManagerTitle//✅
    
    case changeRM_BATips//✅
    
    case code//✅
    
    //MARK: ====== 绑定邮箱
    
    case toAdd
    
    case currentEmail
    
    case changeEmail
    
    case bindEmail
    
    case updateEmail
    
    case enterEmailTips
        
    case getEmailVerficationCode

    case verifyEmail
    
    case verificationCodeHasBeenSentTips
    
    case resend
    
    case enterEmailVerficationCode
                
    case incorrectVerificationCodeTips
    
    case nextStep
                    
    case boundSuccessfully
    
    case updateSuccessfully
    
    case done
    
    //MARK: ====== 修改昵称
    
    case changeNicknameTitle
    
    case toSet
    
    case changeNicknameTips
    
    case save
    
    case setupFailed
    
    case setupSuccessfully
    
    case expired
    case used
    case available
    
    case noNewsYet
    case messageDetail
    case coupons
    case noCouponsYet
    case bankcard
    case contact_us
    case custom_service
    case Investment_Advisor
    case Settings
    case about

    case noMore
    case inviteJoinTitle //✅
    case inviteJoinDesc1 //✅
    case inviteJoinDesc2 //✅
    case couponBirthdayGift //✅
    case couponNewLenderGift //✅
    case couponUpgradeGift //✅
    case membershipShareContent //✅
    
    case useNow // 新版优惠券
    
    case expirationDate
    
    case noSignal
    case refresh

}

extension Locale: ZJLocalizable {
    
    var key: String { rawValue }
    
    var table: String { "Locale" }
    
    var bundle: Bundle { .framework_ZJPersonal }
    
}
