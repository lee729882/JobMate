package com.jobmate.mapper;

import org.apache.poi.ss.usermodel.*;
import java.io.InputStream;
import java.util.*;

public class ExcelCodeMapper {

    private static final Map<String, String> OCC_MAP = new HashMap<>();
    private static final Map<String, String> REGION_MAP = new HashMap<>();
    private static boolean initialized = false;

    public static void loadAllCodes() {
        if (initialized) return;

        loadExcel("/com/jobmate/code/직종코드.xls", OCC_MAP);
        loadExcel("/com/jobmate/code/지역코드.xls", REGION_MAP);

        initialized = true;
        System.out.println("✅ [INFO] 코드파일 로드 완료: 직종 " + OCC_MAP.size() + "건, 지역 " + REGION_MAP.size() + "건");
    }

    private static void loadExcel(String resourcePath, Map<String, String> targetMap) {
        try (InputStream is = ExcelCodeMapper.class.getResourceAsStream(resourcePath)) {
            if (is == null) {
                System.err.println("❌ [ERROR] 리소스 파일을 찾을 수 없습니다: " + resourcePath);
                return;
            }

            Workbook workbook = WorkbookFactory.create(is);
            Sheet sheet = workbook.getSheetAt(0);

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                String internalCode = getCellValue(row.getCell(0)); // A열: 코드
                String name = getCellValue(row.getCell(3));         // D열: 3_depth (소분류)

                if (!internalCode.isEmpty() && !name.isEmpty()) {
                    targetMap.put(internalCode, name);
                }
            }

            workbook.close();
            System.out.println("📘 [INFO] " + resourcePath + " 로드 완료 (" + targetMap.size() + "건)");
        } catch (Exception e) {
            System.err.println("❌ [ERROR] Excel 코드파일 로드 실패: " + resourcePath);
            e.printStackTrace();
        }
    }

    // ✅ 기존 유지: 2단계 직종
    public static Map<String, Map<String, List<Map<String, String>>>> getGroupedOccupations() {
        Map<String, Map<String, List<Map<String, String>>>> grouped = new LinkedHashMap<>();

        try (InputStream is = ExcelCodeMapper.class.getResourceAsStream("/com/jobmate/code/직종코드.xls")) {
            if (is == null) {
                System.err.println("❌ [ERROR] 직종코드.xls 파일을 찾을 수 없습니다.");
                return grouped;
            }

            Workbook workbook = WorkbookFactory.create(is);
            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter fmt = new DataFormatter();

            String currentDepth1 = ""; // 대분류
            String currentDepth2 = ""; // 중분류

            for (Row row : sheet) {
                if (row == null) continue;

                String code   = fmt.formatCellValue(row.getCell(0)).trim(); // 코드
                String depth1 = fmt.formatCellValue(row.getCell(1)).trim(); // 1_depth
                String depth2 = fmt.formatCellValue(row.getCell(2)).trim(); // 2_depth
                String depth3 = fmt.formatCellValue(row.getCell(3)).trim(); // 3_depth

                // ✅ 숫자만 있는 depth1 행 (예: 12, 13 등) 무시
                if (depth1.matches("^\\d+$")) continue;

                // ✅ 새로운 대분류 시작
                if (!depth1.isEmpty()) {
                    currentDepth1 = depth1;
                    grouped.putIfAbsent(currentDepth1, new LinkedHashMap<>());
                }

                // ✅ 중분류 갱신
                if (!depth2.isEmpty()) {
                    currentDepth2 = depth2;
                    grouped.get(currentDepth1).putIfAbsent(currentDepth2, new ArrayList<>());
                }

                // ✅ 소분류(3depth) 추가
                if (!depth3.isEmpty() && !code.isEmpty() && !currentDepth1.isEmpty() && !currentDepth2.isEmpty()) {
                    Map<String, String> item = new LinkedHashMap<>();
                    item.put("code", code);
                    item.put("name", depth3);
                    grouped.get(currentDepth1).get(currentDepth2).add(item);
                }
            }

            workbook.close();
            System.out.println("📘 [INFO] 직종 3단계 분류 로드 완료: " + grouped.size() + "개 대분류");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return grouped;
    }


    // ✅ 새로 추가: 3단계 직종 (대분류 → 중분류 → 소분류)
    public static Map<String, Map<String, List<Map<String, String>>>> getGroupedOccupations3Depth() {
        Map<String, Map<String, List<Map<String, String>>>> grouped = new LinkedHashMap<>();

        try (InputStream is = ExcelCodeMapper.class.getResourceAsStream("/com/jobmate/code/직종코드.xls")) {
            if (is == null) {
                System.err.println("❌ [ERROR] 직종코드.xls 파일을 찾을 수 없습니다.");
                return grouped;
            }

            Workbook workbook = WorkbookFactory.create(is);
            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter fmt = new DataFormatter();

            for (Row row : sheet) {
                if (row == null) continue;

                String code   = fmt.formatCellValue(row.getCell(0)).trim(); // A: 코드
                String depth1 = fmt.formatCellValue(row.getCell(1)).trim(); // B: 대분류
                String depth2 = fmt.formatCellValue(row.getCell(2)).trim(); // C: 중분류
                String depth3 = fmt.formatCellValue(row.getCell(3)).trim(); // D: 소분류

                if (depth1.isEmpty() || depth2.isEmpty() || depth3.isEmpty() || code.isEmpty())
                    continue;

                grouped
                    .computeIfAbsent(depth1, k -> new LinkedHashMap<>())
                    .computeIfAbsent(depth2, k -> new ArrayList<>())
                    .add(Map.of("code", code, "name", depth3));
            }

            workbook.close();
            System.out.println("📘 [INFO] 직종 분류 로드 완료(3단계): " + grouped.size() + "개 대분류");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return grouped;
    }

 // ✅ 지역 2단계 구조
    public static Map<String, List<Map<String, String>>> getGroupedRegions() {
        Map<String, List<Map<String, String>>> grouped = new LinkedHashMap<>();

        try (InputStream is = ExcelCodeMapper.class.getResourceAsStream("/com/jobmate/code/지역코드.xls")) {
            if (is == null) {
                System.err.println("❌ [ERROR] 지역코드.xls 파일을 찾을 수 없습니다.");
                return grouped;
            }

            Workbook workbook = WorkbookFactory.create(is);
            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter fmt = new DataFormatter();

            String currentRegion1 = ""; // 광역시·도 이름

            for (Row row : sheet) {
                if (row == null) continue;

                String code = fmt.formatCellValue(row.getCell(0)).trim();  // 코드
                String region1 = fmt.formatCellValue(row.getCell(1)).trim(); // 광역시/도
                String region2 = fmt.formatCellValue(row.getCell(2)).trim(); // 시군구

                // 숫자만 있는 행 무시
                if (region1.matches("^\\d+$")) continue;

                // 새로운 광역시·도
                if (!region1.isEmpty()) {
                    currentRegion1 = region1;
                    grouped.putIfAbsent(currentRegion1, new ArrayList<>());
                }

                // 유효한 시군구 추가
                if (!region2.isEmpty() && !code.isEmpty()) {
                    Map<String, String> item = new LinkedHashMap<>();
                    item.put("code", code);
                    item.put("name", region2);
                    grouped.get(currentRegion1).add(item);
                }
            }

            workbook.close();
            System.out.println("📘 [INFO] 지역 2단계 분류 로드 완료: " + grouped.size() + "개 광역시");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return grouped;
    }


    private static String getCellValue(Cell cell) {
        if (cell == null) return "";
        return cell.toString().trim();
    }
    public static String getOccupation(String code) {
        loadAllCodes();
        return OCC_MAP.getOrDefault(code, code); // 존재하지 않으면 그대로 반환
    }

    public static String getRegion(String code) {
        loadAllCodes();
        return REGION_MAP.getOrDefault(code, code); // 존재하지 않으면 그대로 반환
    }
}
