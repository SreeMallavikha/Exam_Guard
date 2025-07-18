// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExamContract {
    struct Exam {
        string examName;
        uint256 startTime;
        uint256 endTime;
        uint256 duration;
        uint256 totalMarks;
        uint256 totalQuestions;
    }

    mapping(uint256 => Exam) public exams;
    uint256 public examCount;

    function createExam(
        string memory _examName,
        uint256 _startTime,
        uint256 _endTime,
        uint256 _duration,
        uint256 _totalMarks,
        uint256 _totalQuestions
    ) public {
        exams[examCount] = Exam(_examName, _startTime, _endTime, _duration, _totalMarks, _totalQuestions);
        examCount++;
    }

    function getExamDetails(uint256 examId)
        public
        view
        returns (string memory, uint256, uint256, uint256, uint256, uint256)
    {
        require(examId < examCount, "Invalid Exam ID");
        Exam memory e = exams[examId];
        return (e.examName, e.startTime, e.endTime, e.duration, e.totalMarks, e.totalQuestions);
    }
}
