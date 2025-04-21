package kr.or.ddit.approval.common;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * 
 * @author CHOI
 * @since 2025. 4. 1.
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      			수정자           수정내용
 *  -----------   	-------------    ---------------------------
 *  2025. 4. 1.     	CHOI	          로그인한 사용자 -> 시큐리티를 통해 가져옴
 *
 * </pre>
 */
public class AuthUtil {
    /**
     * 로그인한 사용자의 empId를 반환하는 공통 메서드.
     */
    public static String getLoggedInUserId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            return ((UserDetails) principal).getUsername();
        }
        return null;
    }
}
