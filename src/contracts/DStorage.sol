pragma solidity ^0.5.0;

contract DStorage {
  string public name = 'DStorage';
  uint public fileCount = 0;
  mapping(uint => File) public files;

  struct File {
    uint fileId;
    string fileHash;
    string fileTeamA;
    string fileTeamB;
    string fileDescription;
    uint date;
    uint uploadTime;
    address payable uploader;
  }

  event FileUploaded(
    uint fileId,
    string fileHash,
    string fileTeamA,
    string fileTeamB,
    string fileDescription,
    uint date,
    uint uploadTime,
    address payable uploader
  );

  constructor() public {
  }

  function uploadFile(string memory _fileHash, string memory _fileTeamA, string memory _fileTeamB, string memory _fileDescription, uint _date) public {
    // Make sure the file hash exists
    require(bytes(_fileHash).length > 0);
    // Make sure file type exists
    require(bytes(_fileTeamA).length > 0);
    // Make sure file description exists
    require(bytes(_fileDescription).length > 0);
    // Make sure file fileName exists
    require(bytes(_fileTeamB).length > 0);
    // Make sure uploader address exists
    require(msg.sender!=address(0));

    // Increment file id
    fileCount ++;

    // Add File to the contract
    files[fileCount] = File(fileCount, _fileHash, _fileTeamA, _fileTeamB, _fileDescription, _date, now, msg.sender);
    // Trigger an event
    emit FileUploaded(fileCount, _fileHash, _fileTeamA, _fileTeamB, _fileDescription, _date, now, msg.sender);
  }
}