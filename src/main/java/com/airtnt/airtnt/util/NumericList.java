package com.airtnt.airtnt.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 정수형식의 문자열이나 숫자로 이루어진
 * 배열이나 리스트 간의 빠른 전환을 도와줌
 */
public class NumericList {
	
	// String.valueOf(null Integer)은 "null" 문자열을 리턴하므로
	// .toString()으로 NullPointerException을 유도함
	
	// String array
	public static String[] toStringArray(int... intArray) {
		if(intArray == null) {
			return null;
		}
		String[] stringArray = new String[intArray.length];
		for(int i = 0; i < intArray.length; i++) {
			stringArray[i] = String.valueOf(intArray[i]);
		}
		return stringArray;
	}
	
	public static String[] toStringArray(Integer[] integerArray) {
		if(integerArray == null) {
			return null;
		}
		String[] stringArray = new String[integerArray.length];
		for(int i = 0; i < integerArray.length; i++) {
			stringArray[i] = integerArray[i].toString();
		}
		return stringArray;
	}
	
	public static String[] toStringArray(List<Integer> integers) {
		if(integers == null) {
			return null;
		}
		String[] stringArray = new String[integers.size()];
		for(int i = 0; i < integers.size(); i++) {
			stringArray[i] = integers.get(i).toString();
		}
		return stringArray;
	}
	
	
	// String List
	public static List<String> toStringList(int... intArray){
		if(intArray == null) {
			return null;
		}
		List<String> strings = new ArrayList<>();
		for(int i = 0; i < intArray.length; i++) {
			strings.add(String.valueOf(intArray[i]));
		}
		return strings;
	}
	
	public static List<String> toStringList(Integer[] integerArray){
		if(integerArray == null) {
			return null;
		}
		List<String> strings = new ArrayList<>();
		for(int i = 0; i < integerArray.length; i++) {
			strings.add(integerArray[i].toString());
		}
		return strings;
	}
	
	public static List<String> toStringList(List<Integer> integers){
		if(integers == null) {
			return null;
		}
		List<String> strings = new ArrayList<>();
		for(Integer integer : integers) {
			strings.add(integer.toString());
		}
		return strings;
	}
	
	
	// Integer.parseInt()와 Integer.valueOf()모두
	// null을 포함한 숫자형식에 맞지 않는 String에 대하여
	// NumberFormatException을 발생시킴
	
	// int array
	public static int[] toIntArray(String... stringArray) {
		if(stringArray == null) {
			return null;
		}
		int[] intArray = new int[stringArray.length];
		for(int i = 0; i < stringArray.length; i++) {
			intArray[i] = Integer.parseInt(stringArray[i]);
		}
		return intArray;
	}
	
	public static int[] toIntArray(List<String> strings) {
		if(strings == null) {
			return null;
		}
		int[] intArray = new int[strings.size()];
		for(int i = 0; i < strings.size(); i++) {
			intArray[i] = Integer.parseInt(strings.get(i));
		}
		return intArray;
	}
	
	
	// Integer array
	public static Integer[] toIntegerArray(String... stringArray) {
		if(stringArray == null) {
			return null;
		}
		Integer[] integerArray = new Integer[stringArray.length];
		for(int i = 0; i < stringArray.length; i++) {
			integerArray[i] = Integer.valueOf(stringArray[i]);
		}
		return integerArray;
	}
	
	public static Integer[] toIntegerArray(List<String> strings) {
		if(strings == null) {
			return null;
		}
		Integer[] integerArray = new Integer[strings.size()];
		for(int i = 0; i < strings.size(); i++) {
			integerArray[i] = Integer.valueOf(strings.get(i));
		}
		return integerArray;
	}
	
	
	// Integer List
	public static List<Integer> toIntegerList(String... stringArray){
		if(stringArray == null) {
			return null;
		}
		List<Integer> integers = new ArrayList<>();
		for(int i = 0; i < stringArray.length; i++) {
			integers.add(Integer.valueOf(stringArray[i]));
		}
		return integers;
	}
	
	public static List<Integer> toIntegerList(List<String> strings){
		if(strings == null) {
			return null;
		}
		List<Integer> integers = new ArrayList<>();
		for(String string : strings) {
			integers.add(Integer.valueOf(string));
		}
		return integers;
	}
}
