package com.ikeo.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.java.Log;

// 자동생성 - @Controller, @Service, @Repository, @Component, @RestController, @Advice
@Component
@Aspect
@Log
public class LogAdvice {

	// 실행 시점과 적용 - @Before, @After, @Around
	@Around("execution(* com.webjjang.*.service.*.*(..))")
	// pjp - 실행할 객체와 파라메터로 넘기는 데이터가 포함이되어 있는 객체
	// 1. 실행 객체 이름 / 2. 넘어가는 데이터 출력 / 3. 실행 결과 출력 / 4. 실행 시간 nano sec.로 출력
	public Object run(ProceedingJoinPoint pjp) throws Throwable {
		Object  result = null;
		
		// 실행 전 시간
		long start = System.nanoTime();
		
		// 처리해야할 프로세서 - 게시판 리스트 --> BoardService.list()
		result = pjp.proceed();
		
		// 실행 후 시간
		long end = System.nanoTime();
		
		log.info("<<----- AOP 처리 - 로그출력 -------------------->>>>>>>");
		// 실행 객체 이름 출력
		log.info(">> 실행 객체 : " + pjp.getTarget());
		// 넘어가는 데이터
		log.info(">> 넘어가는 데이터 : " + Arrays.toString(pjp.getArgs()));
		
		// 실행 결과 데이터 출력
		log.info(">> 실행결과 데이터 : " + result);
		
		// 실행 시간 출력
		log.info(">> 실행 시간 : " + (end - start) + " ns");
		
		log.info("<<----------------------------------------->>>>>>>");
		
		return result;
	}
	
}
